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

- (void)setFlushParamsWithDuration:(NSInteger)durationInSeconds
                   withMaxElements:(NSInteger)maxElements
{
    self.eventQueue = [[EventQueue alloc] initWithSize:maxElements andTime:durationInSeconds];
    [NSTimer scheduledTimerWithTimeInterval:maxElements
                                     target:self
                                   selector:@selector(checkQueue)
                                   userInfo:nil
                                    repeats:YES];
}

- (NSString*)getDeviceName:(NSString*)deviceName
{
    NSCharacterSet* charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString* strippedReplacement = [[deviceName componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    return strippedReplacement;
}

- (NSString*)getCarrierName
{
    CTTelephonyNetworkInfo* netinfo = [CTTelephonyNetworkInfo new];
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
           idfaOptIn:(bool)optIn
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties
{
    self.vendorProperties = vendorProperties;
    if (self = [self init]) {
        self.organizationId = organizationId;
        self.projectId = projectId;
        self.api = [[DatasnapAPI alloc] initWithKey:apiKey secret:apiKeySecret];
        self.baseClient = [BaseClient new];
        self.baseClient.projectId = projectId;
        self.baseClient.organizationId = organizationId;
        self.optIn = optIn;
        self.email = email;
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
    self.device = [Device new];
    [self setDeviceAndReturn:self.device];
    self.deviceInfo = [DeviceInfo new];
    self.deviceInfo.device = self.device;
    self.baseClient.deviceInfo = self.deviceInfo;
    self.user = [User new];
    [self.user initializeUser:self.user];
    self.baseClient.user = self.user;
    self.identifier = [Identifier new];
    if (self.optIn == YES) {
        NSString* mobile_device_ios_idfa = [self identifierForAdvertising];
        self.identifier.mobileDeviceIosIdfa = mobile_device_ios_idfa;
        self.identifier.mobileDeviceGoogleAdvertisingIdOptIn = @"YES";
    }
    else {
        self.identifier.mobileDeviceGoogleAdvertisingIdOptIn = @"NO";
    }
    self.identifier.globalDistinctId = [[NSUUID UUID] UUIDString];
    self.identifier.hashedEmail = self.email;
    self.user.identifier = self.identifier;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [self checkQueue];
        //ensure Gimbal is started if application is started offline. Gimbal cannot properly initialize if the app is offline during startup.
        if (!self.gimbalClient && self.vendorProperties.vendor == GIMBAL) {
            self.gimbalClient = [GimbalClient new];
            self.gimbalClient.gimbalApiKey = self.vendorProperties.gimbalApiKey;
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
            self.gimbalClient = [GimbalClient new];
            self.gimbalClient.gimbalApiKey = self.vendorProperties.gimbalApiKey;
            [self.gimbalClient startGimbal];
        }
        break;
    case ESTIMOTE:
        break;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isAppAlreadyLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAppAlreadyLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString* eventType = appInstalledEventType;
        BaseEvent* event = [BaseEvent new];
        event.eventType = eventType;
        event.organizationIds = @[ self.organizationId ];
        event.projectIds = @[ self.projectId ];
        event.user = self.user;
        [self trackEvent:event];
    }
}

- (void)trackEvent:(BaseEvent*)event
{
    event.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    event.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    event.deviceInfo = self.deviceInfo;
    event.user = self.user;
    event.organizationIds = @[ self.organizationId ];
    event.projectIds = @[ self.projectId ];
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
                [self flushEvents];
            }
        }
    }
}

- (NSString*)sha1:(NSString*)input
{
    const char* cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [NSData dataWithBytes:cstr length:input.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, data.length, digest);

    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}

- (void)flushEvents
{
    [self.eventQueue flushQueue];
}

@end
