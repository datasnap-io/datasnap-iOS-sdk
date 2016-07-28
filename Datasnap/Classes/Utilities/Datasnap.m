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
NSString* const GimbalClientInitializerMethod = @"initWithVendorProperties:organizationId:projectId:";

NSString* const IsAppAlreadyLaunchedOnceKey = @"isAppAlreadyLaunchedOnceKey";
NSString* const AppInstalledEventType = @"appInstalledEventType";

@interface Datasnap ()
@property (nonatomic) EventEntity* event;
@property (nonatomic) VendorProperties* vendorProperties;
@property (nonatomic) id gimbalClient;
@property (nonatomic, strong) NSString* organizationId;
@property (nonatomic, strong) NSString* projectId;
@property (nonatomic) BaseClient* baseClient;
@property (nonatomic) NSTimer* timer;
@property (nonatomic) NSString* mobileDeviceIosIdfa;
@property (nonatomic) NSInteger durationInMillis;
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
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties
{
    if (self = [self init]) {
        self.organizationId = organizationId;
        self.projectId = projectId;
        self.api = [[DatasnapAPI alloc] initWithKey:apiKey secret:apiKeySecret];
        self.email = email;
        self.vendorProperties = vendorProperties;
    }
    [self initializeData];
    return self;
}

- (void)initializeData
{
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
                                                           projectId:self.projectId];
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
        [inv setArgument:&self->_organizationId atIndex:3];
        [inv setArgument:&self->_projectId atIndex:4];
        [inv invoke];
    }
    else {
        NSLog(@"Gimbal library not found, please add Gimbal to podfile using pod 'Gimbal' and run pod install");
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
    self.durationInMillis = durationInMillis;
    self.eventQueue = [[EventQueue alloc] initWithSize:maxElements andTime:durationInMillis];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:durationInMillis
                                                  target:self
                                                selector:@selector(checkQueue)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)checkQueue
{
    if ([self connected]) {
        NSMutableArray* events = [self.eventQueue getEvents];
        if (events.count > 0) {
            NSLog(@"Queue is full. %d events will be sent to service and flushed.", events.count);
            if ([self.api sendEvents:events]) {
                [self.eventQueue flushQueue:events];
                if ([EventEntity returnAllEvents].count > 0) {
                    [self checkQueue];
                }
            }
            else {
                NSLog(@"API request unsuccessful. %d events will remain in queue.", events.count);
                [self.timer invalidate];
                self.durationInMillis = self.durationInMillis * 2;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:self.durationInMillis
                                                              target:self
                                                            selector:@selector(checkQueue)
                                                            userInfo:nil
                                                             repeats:YES];
            }
        }
    }
}

#pragma mark Event Tracking

- (void)trackEvent:(BaseEvent*)event withIDFA:(NSString*)idfa
{
    self.idfa = idfa;
    [self trackEvent:event];
}

- (void)trackEvent:(BaseEvent*)event
{
    event.organization_ids = @[ self.organizationId ];
    event.project_ids = @[ self.projectId ];
    Device* device = [[Device alloc] init];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    event.eventProperty = [[EventProperty alloc] initWithDate:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]] andDevice:device];
    Identifier* identifier = [[Identifier alloc] initWithGlobalDistinctId:self.UUID ? self.UUID : [[[UIDevice currentDevice] identifierForVendor] UUIDString]
                                                  andSha1_lowercase_email:self.email ? [self.email toSha1] : nil
                                                                  andIDFA:self.idfa ? self.idfa : nil];
    self.idfa = nil;
    event.user = [[User alloc] initWithIdentifier:identifier];
    NSDictionary* eventJson = [event dictionary];
    [self.eventQueue recordEvent:eventJson];
}

@end
