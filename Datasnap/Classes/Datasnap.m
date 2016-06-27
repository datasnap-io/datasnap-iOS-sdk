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
@implementation Datasnap
- (Device*)setDeviceAndReturn:(Device*)device
{
    device.manufacturer = @"Apple";
    device.model = [UIDevice currentDevice].model;
    device.platform = [UIDevice currentDevice].systemName;
    device.osVersion = [UIDevice currentDevice].systemVersion;
    device.name = [self getDeviceName:[UIDevice currentDevice].name];
    device.vendorId = [NSString stringWithFormat:@"%@", [UIDevice currentDevice].identifierForVendor];
    device.carrierName = [self getCarrierName];
    device.ipAddress = [self getIPAddress];
    device.countryCode = [self getCountyCode];
    return device;
}

+ (void)setFlushParamsWithDuration:(NSInteger)durationInMillis
                   withMaxElements:(NSInteger)maxElements
{
}

- (NSString*)getDeviceName:(NSString*)deviceName
{
    NSCharacterSet* charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString* strippedReplacement = [[deviceName componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    return strippedReplacement;
}

- (NSString*)getCarrierName
{
    CTTelephonyNetworkInfo* netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier* carrier = [netinfo subscriberCellularProvider];
    return [carrier carrierName];
}

- (NSString*)getIPAddress
{
    NSString* address = @"error";
    struct ifaddrs* interfaces = NULL;
    struct ifaddrs* temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in*)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

- (NSString*)getCountyCode
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    return countryCode;
}

- (id)initWithApiKey:(NSString*)apiKey
        apiKeySecret:(NSString*)apiKeySecret
      organizationId:(NSString*)organizationId
           projectId:(NSString*)projectId
      eventQueueSize:(NSInteger)eventNum
 andVendorProperties:(VendorProperties*)vendorProperties
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    self.vendorProperties = vendorProperties;
    if (self = [self init]) {
        self.organizationId = organizationId;
        self.projectId = projectId;
        self.eventQueue = [[EventQueue alloc] initWithSize:eventNum];
        self.api = [[DatasnapAPI alloc] initWithKey:apiKey secret:apiKeySecret];
        self.baseClient = [[BaseClient alloc] init];
        self.baseClient.projectId = projectId;
        self.baseClient.organizationId = organizationId;
    }
    [self initializeData];
    return self;
}

+ (id)sharedClient
{
    static Datasnap* sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

- (void)initializeData
{
    self.device = [[Device alloc] init];
    [self setDeviceAndReturn:self.device];
    self.deviceInfo = [[DeviceInfo alloc] init];
    self.deviceInfo.device = self.device;
    self.baseClient.deviceInfo = self.deviceInfo;
    self.user = [[User alloc] init];
    [self.user initializeUser:self.user];
    self.baseClient.user = self.user;
    self.identifier = [[Identifier alloc] init];
    if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"SEND_ADVERTISER_ID"]) {
        NSString* mobile_device_ios_idfa = [self identifierForAdvertising];
        self.identifier.mobileDeviceIosIdfa = mobile_device_ios_idfa;
        self.identifier.mobileDeviceGoogleAdvertisingIdOptIn = @"YES";
    }
    else {
        self.identifier.mobileDeviceGoogleAdvertisingIdOptIn = @"NO";
    }
    self.identifier.globalDistinctId = [[NSUUID UUID] UUIDString];
    self.user.identifier = self.identifier;
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
        self.gimbalClient = [[GimbalClient alloc] init];
        self.gimbalClient.gimbalApiKey = self.vendorProperties.gimbalApiKey;
        [self.gimbalClient startGimbal];
        break;
    case ESTIMOTE:
        break;
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isAppAlreadyLaunchedOnce"]) {
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAppAlreadyLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString* eventType = appInstalledEventType;
        BaseEvent* event = [[BaseEvent alloc] init];
        event.eventType = eventType;
        [event.organizationIds addObject:self.organizationId];
        [event.projectIds addObject:self.projectId];
        event.user = self.user;
        [self trackEvent:event];
    }
}

- (void)trackEvent:(BaseEvent*)event
{
    event.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    event.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    event.deviceInfo = self.deviceInfo;
    event.user = self.user;
    event.organizationIds = [[NSMutableArray alloc] init];
    event.projectIds = [[NSMutableArray alloc] init];
    [event.organizationIds addObject:self.organizationId];
    [event.projectIds addObject:self.projectId];
    if (![event validate]) {
        NSLog(@"Mandatory event data missing. Please call Datasnap.initialize before using the library");
    }
    NSDictionary* eventJson = [event convertToDictionary];
    [self.eventQueue recordEvent:eventJson];
    [self checkQueue];
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
                [self flushEvents];
            }
        }
    }
}

- (void)flushEvents
{
    [self.eventQueue flushQueue];
}

- (void)genericEvent:(NSMutableDictionary*)eventDetails
{
    [self eventHandler:eventDetails];
}

- (void)eventHandler:(NSMutableDictionary*)eventDetails
{
    NSMutableDictionary* eventDetailsCopy = [eventDetails mutableCopy];
    NSDictionary* deviceInfo = [self deviceInfoDictionary];
    [eventDetailsCopy addEntriesFromDictionary:@{ @"organization_ids" : @[ self.organizationId ],
        @"project_ids" : @[ self.projectId ],
        @"sdk_version" : @"1.0.4",
        @"device_info" : @{
            @"platform" : [deviceInfo objectForKey:@"platform"],
            @"system_name" : [deviceInfo objectForKey:@"system_name"],
            @"system_version" : [deviceInfo objectForKey:@"system_version"]
        }
    }];
    [self.eventQueue recordEvent:eventDetailsCopy];
    [self checkQueue];
}

- (NSDictionary*)deviceInfoDictionary
{
    NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
    [info setObject:[UIDevice currentDevice].model forKey:@"platform"];
    [info setObject:[UIDevice currentDevice].systemName forKey:@"system_name"];
    [info setObject:[UIDevice currentDevice].systemVersion forKey:@"system_version"];
    [info setObject:[UIDevice currentDevice].name forKey:@"device_name"];
    return info;
}

@end
