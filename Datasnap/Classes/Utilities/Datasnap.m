//
//  Datasnap.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Datasnap.h"

static Datasnap* sharedInstance = nil;
static NSString* appInstalledEventType = @"app_installed";
NSString* googleAd = @"NO";
@implementation Datasnap

- (void)setFlushParamsWithDuration:(NSInteger)durationInMillis
                   withMaxElements:(NSInteger)maxElements
{
    self.eventQueue = [[EventQueue alloc] initWithSize:maxElements andTime:durationInMillis];
    [NSTimer scheduledTimerWithTimeInterval:maxElements
                                     target:self
                                   selector:@selector(checkQueue)
                                   userInfo:nil
                                    repeats:YES];
}
- (id)initWithApiKey:(NSString*)apiKey
        apiKeySecret:(NSString*)apiKeySecret
      organizationId:(NSString*)organizationId
           projectId:(NSString*)projectId
       googleAdOptIn:(bool)googleAdOptIn
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties
{
    if (self = [self init]) {
        self.organizationId = organizationId;
        self.projectId = projectId;
        self.api = [[DatasnapAPI alloc] initWithKey:apiKey secret:apiKeySecret];
        self.googleAdOptIn = googleAdOptIn;
        self.email = email;
        self.vendorProperties = vendorProperties;
    }
    [self initializeData];
    return self;
}
+ (id)sharedClient
{
    static Datasnap* sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [self new];
    });
    return sharedClient;
}
- (void)initializeData
{
    if (self.googleAdOptIn) {
        googleAd = @"YES";
        self.mobileDeviceIosIdfa = [self identifierForAdvertising];
    }
    self.identifier = [[Identifier alloc] initWithDatasnapUuid:[NSNull null]
                                               domainSessionId:NULL
                                                  facebookUuid:nil
                                              globalDistinctId:[[NSUUID UUID] UUIDString]
                                           globalUserIpAddress:self.device.ipAddress
                                                   hashedEmail:[self.email toSha1]
                               mobileDeviceBluetoothIdentifier:nil
                                           mobileDeviceIosIdfa:self.mobileDeviceIosIdfa
                                           mobileDeviceIosUdid:[[NSUUID UUID] UUIDString]
                                       mobileDeviceFingerprint:nil
                          mobileDeviceGoogleAdvertisingIdOptIn:googleAd
                                               webDomainUserId:nil
                                                     webCookie:nil
                                              webNetworkUserId:nil
                                            webUserFingerPrint:nil
                                    webAnalyticsCompanyZCookie:nil
                                                    andUnknown:nil];
    self.device = [[Device alloc] init];
    self.user = [[User alloc] initWithIdentifier:self.identifier
                                            tags:nil
                                        audience:nil
                               andUserProperties:nil];
    self.baseClient = [[BaseClient alloc] initWithOrganizationId:self.organizationId
                                                       projectId:self.projectId
                                                          device:self.device
                                                         andUser:self.user];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [self checkQueue];
        //ensure Gimbal is started if application is started offline. Gimbal cannot properly initialize if the app is offline during startup.
        if (!self.gimbalClient && self.vendorProperties.vendor == GIMBAL) {
            self.gimbalClient = [[GimbalClient alloc] initWithGimbalApiKey:self.vendorProperties.gimbalApiKey
                                                                    device:self.device
                                                            organizationId:self.organizationId
                                                                 projectId:self.projectId
                                                                   andUser:self.user];
            [self.gimbalClient startGimbal];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self onDataInitialized];
}
- (NSString*)identifierForAdvertising
{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSUUID* IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        return [IDFA UUIDString];
    }
    return nil;
}

- (void)onDataInitialized
{
    if (!self.vendorProperties) {
        return;
    }
    switch (self.vendorProperties.vendor) {
    case GIMBAL:
        if ([AFNetworkReachabilityManager sharedManager].reachable) {
            self.gimbalClient = [[GimbalClient alloc] initWithGimbalApiKey:self.vendorProperties.gimbalApiKey
                                                                    device:self.device
                                                            organizationId:self.organizationId
                                                                 projectId:self.projectId
                                                                   andUser:self.user];
            [self.gimbalClient startGimbal];
        }
        break;
    case ESTIMOTE:
        break;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isAppAlreadyLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAppAlreadyLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        BaseEvent* event = [[BaseEvent alloc] initWithEventType:@"appInstalledEventType"];
        [self trackEvent:event];
    }
}

- (void)trackEvent:(BaseEvent*)event
{
    event.organizationIds = @[ self.organizationId ];
    event.projectIds = @[ self.projectId ];
    event.user = self.user;
    event.device = self.device;
    if (![event validate]) {
        NSLog(@"Mandatory event data missing. Please call Datasnap.initialize before using the library");
    }
    NSDictionary* eventJson = [event convertToDictionary];
    if (self.eventQueue.numberOfQueuedEvents <= self.eventQueue.maxQueueLength) {
        [self.eventQueue recordEvent:eventJson];
    }
}

+ (void)debug:(BOOL)showDebugLogs
{
    DSIOSetShowDebugLogs(showDebugLogs);
}

- (BOOL)connected
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)checkQueue
{
    if ([self connected]) {
        if (self.eventQueue.numberOfQueuedEvents >= self.eventQueue.queueLength) {
            if ([self.api sendEvents:self.eventQueue.getEvents]) {
                DSIOLog(@"Queue is full. %d will be sent to service and flushed.", (int)self.eventQueue.numberOfQueuedEvents);
                [self.eventQueue flushQueue];
            }
        }
    }
}

@end
