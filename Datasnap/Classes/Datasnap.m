//
//  Datasnap.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Datasnap.h"
//TODO: move file to root
static Datasnap* sharedInstance = nil;
static NSString* appInstalledEventType = @"app_installed";

NSString* const GimbalClientClassName = @"GimbalClient";
NSString* const GimbalClientInitializerMethod = @"initWithVendorProperties:device:organizationId:projectId:andUser:";

NSString* const IsAppAlreadyLaunchedOnceKey = @"isAppAlreadyLaunchedOnceKey";
NSString* const AppInstalledEventType = @"appInstalledEventType";

@interface Datasnap ()
@property (nonatomic) EventEntity* event;
@property (nonatomic) Device* device;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) Identifier* identifier;
@property (nonatomic) VendorProperties* vendorProperties;
@property (nonatomic) id gimbalClient;
@property (nonatomic, strong) NSString* organizationId;
@property (nonatomic, strong) NSString* projectId;
@property (nonatomic) EventQueue* eventQueue;
@property (nonatomic) BaseClient* baseClient;
@property (nonatomic) NSTimer* timer;
@property (nonatomic) bool googleAdOptIn;
@property (nonatomic) NSString* email;
@property (nonatomic) NSString* mobileDeviceIosIdfa;
@end

@implementation Datasnap

+ (id)sharedClient
{
    static Datasnap* sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [self new];
    });
    return sharedClient;
}

#pragma mark Datasnap Initialization

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

- (void)initializeData
{
    self.device = [[Device alloc] init];
    self.identifier = [[Identifier alloc] initWithDatasnapUuid:[NSNull null]
                                               domainSessionId:NULL
                                                  facebookUuid:nil
                                              globalDistinctId:[[NSUUID UUID] UUIDString]
                                           globalUserIpAddress:self.device.ipAddress
                                                   hashedEmail:self.email ? [self.email toSha1] : nil
                               mobileDeviceBluetoothIdentifier:nil
                                           mobileDeviceIosIdfa:self.mobileDeviceIosIdfa
                                           mobileDeviceIosUdid:[[NSUUID UUID] UUIDString]
                                       mobileDeviceFingerprint:nil
                          mobileDeviceGoogleAdvertisingIdOptIn:self.googleAdOptIn ? @"YES" : @"NO"
                                               webDomainUserId:nil
                                                     webCookie:nil
                                              webNetworkUserId:nil
                                            webUserFingerPrint:nil
                                    webAnalyticsCompanyZCookie:nil
                                                    andUnknown:nil];

    self.user = [[User alloc] initWithIdentifier:self.identifier
                                            tags:nil
                                        audience:nil
                               andUserProperties:nil];

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [self checkQueue];
        // Ensure Gimbal is started if application is started offline.
        // Gimbal cannot properly initialize if the app is offline during startup.
        if (!self.gimbalClient && self.vendorProperties && self.vendorProperties.vendor == GIMBAL && [self connected]) {
            [self initializeGimbal];
        }
    }];

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self onDataInitialized];
}

- (void)onDataInitialized
{
    if (!self.vendorProperties) {
        return;
    }
    switch (self.vendorProperties.vendor) {
    case GIMBAL:
        if ([self connected]) {
            // Dynamically call GimbalClient's initialization method
            [self initializeGimbal];
        }
        break;
    case ESTIMOTE:
        break;
    default:
        self.baseClient = [[BaseClient alloc] initWithOrganizationId:self.organizationId
                                                           projectId:self.projectId
                                                              device:self.device
                                                             andUser:self.user];
        break;
    }

    if (![[NSUserDefaults standardUserDefaults] boolForKey:IsAppAlreadyLaunchedOnceKey]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsAppAlreadyLaunchedOnceKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        BaseEvent* event = [[BaseEvent alloc] initWithEventType:AppInstalledEventType];
        [self trackEvent:event];
    }
}

#pragma mark Gimbal

- (void)initializeGimbal
{
    SEL gimbalInit = NSSelectorFromString(GimbalClientInitializerMethod);
    self.gimbalClient = [[NSClassFromString(GimbalClientClassName) alloc] init];
    if ([self.gimbalClient respondsToSelector:gimbalInit]) {
        NSInvocation* inv = [NSInvocation invocationWithMethodSignature:[self.gimbalClient methodSignatureForSelector:gimbalInit]];
        [inv setSelector:gimbalInit];
        [inv setTarget:self.gimbalClient];
        [inv setArgument:&self->_vendorProperties atIndex:2];
        [inv setArgument:&self->_device atIndex:3];
        [inv setArgument:&self->_organizationId atIndex:4];
        [inv setArgument:&self->_projectId atIndex:5];
        [inv setArgument:&self->_user atIndex:6];
        [inv invoke];
    }
}

#pragma mark Network Reachability

- (BOOL)connected
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark Event Queue Handling

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

- (void)checkQueue
{
    if ([self connected]) {
        NSMutableArray* events = self.eventQueue.getEvents;
        if ([self.api sendEvents:events]) {
            NSLog(@"Queue is full. %d events will be sent to service and flushed.", (int)self.eventQueue.numberOfQueuedEvents);
            [self.eventQueue flushQueue:events];
            if ([EventEntity returnAllEvents].count > 0) {
                [self checkQueue];
            }
        }
    }
}

#pragma mark Event Tracking

- (void)trackEvent:(BaseEvent*)event
{
    event.organizationIds = @[ self.organizationId ];
    event.projectIds = @[ self.projectId ];
    event.user = self.user;
    event.device = self.device;
    if (![event isValid]) {
        NSLog(@"Mandatory event data missing. Please call Datasnap.initialize before using the library");
    }
    NSDictionary* eventJson = [event convertToDictionary];
    if (self.eventQueue.numberOfQueuedEvents <= self.eventQueue.maxQueueLength) {
        [self.eventQueue recordEvent:eventJson];
    }
}

@end
