//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//
#import "DSIOAPI.h"
#import "DSIOClient.h"
#import "DSIOConfig.h"
#import "DSIOEventQueue.h"

static DSIOClient* sharedInstance = nil;
static int eventQueueSize = 20;
static NSString* __organizationID;
static NSString* __projectID;
static NSString* __version = @"1.0.4";
static NSString* __platform;

@implementation NSMutableDictionary (AddNotNil)

- (void)addNotNilEntriesFromDictionary:(NSDictionary*)otherDictionary
{
    if (otherDictionary) {
        [self addEntriesFromDictionary:otherDictionary];
    }
}

@end

@interface DSIOClient ()

@property (nonatomic, strong) DSIOAPI* api;

- (void)checkQueue;

@end

@implementation DSIOClient
+ (NSString*)version
{
    return __version;
}

- (NSDictionary*)deviceInfo
{
    NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
    [info setObject:[UIDevice currentDevice].model forKey:@"platform"];
    [info setObject:[UIDevice currentDevice].systemName forKey:@"system_name"];
    [info setObject:[UIDevice currentDevice].systemVersion forKey:@"system_version"];
    [info setObject:[UIDevice currentDevice].name forKey:@"device_name"];
    return info;
}

#pragma mark - Init the SDK with org id, project id, apikey and apisecret

+ (void)setupWithOrgID:(NSString*)organizationID projectId:(NSString*)projectID APIKey:(NSString*)APIKey
             APISecret:(NSString*)APISecret
               logging:(BOOL)logging
              eventNum:(int)eventNum
{
    [self debug:logging];
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithOrgID:organizationID projectId:(NSString*)projectID APIKey:APIKey APISecret:APISecret eventNum:eventNum];
    });
}

- (id)initWithOrgID:(NSString*)organizationID projectId:(NSString*)projectID APIKey:(NSString*)APIKey APISecret:(NSString*)APISecret eventNum:(int)eventNum
{
    if (self = [self init]) {
        __organizationID = organizationID;
        __projectID = projectID;
        eventQueueSize = eventNum;
        self.eventQueue = [[DSIOEventQueue alloc] initWithSize:eventQueueSize];
        self.api = [[DSIOAPI alloc] initWithKey:APIKey secret:APISecret];
    }
    return self;
}

#pragma mark - Event Handler

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
    NSDictionary* deviceInfo = [self deviceInfo];
    [eventDetailsCopy addEntriesFromDictionary:@{ @"organization_ids" : @[ __organizationID ],
        @"project_ids" : @[ __projectID ],
        @"sdk_version" : @[ __version ],
        @"device_info" : @{ @"platform" : [deviceInfo objectForKey:@"platform"],
            @"system_name" : [deviceInfo objectForKey:@"system_name"],
            @"system_version" : [deviceInfo objectForKey:@"system_version"],
            @"device_name" : [deviceInfo objectForKey:@"device_name"] }
    }];
    [self.eventQueue recordEvent:eventDetailsCopy];
    [self checkQueue];
}

+ (id)sharedClient
{
    return sharedInstance;
}

- (void)checkQueue
{
    if (self.eventQueue.numberOfQueuedEvents >= self.eventQueue.queueLength) {
        if ([self.api sendEvents:self.eventQueue.getEvents]) {
            DSIOLog(@"Queue is full. %d will be sent to service and flushed.", (int)self.eventQueue.numberOfQueuedEvents);
            [self flushEvents];
        }
    }
}

#pragma mark - Turn on/off logging

+ (void)debug:(BOOL)showDebugLogs
{
    DSIOSetShowDebugLogs(showDebugLogs);
}

@end
