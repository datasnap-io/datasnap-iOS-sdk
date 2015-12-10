//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//
#import "DSIOClient.h"
#import "DSIOEventQueue.h"
#import "DSIOConfig.h"
#import "DSIOAPI.h"

static DSIOClient *sharedInstance = nil;
static NSString *__version = @"1.0.4";

@implementation NSMutableDictionary (AddNotNil)

- (void)addNotNilEntriesFromDictionary:(NSDictionary *)otherDictionary {
    if (otherDictionary) {
        [self addEntriesFromDictionary:otherDictionary];
    }
}

@end

@interface DSIOClient ()

@property (nonatomic, strong) DSIOEventQueue *eventQueue;
@property (nonatomic, strong) NSString *organizationID;
@property (nonatomic, strong) NSString *projectID;
@property (nonatomic, strong) DSIOAPI *api;

- (void)checkQueue;

@end

@implementation DSIOClient
+ (NSString *) version {
    return __version;
}
#pragma mark - Init the SDK with org id, project id, apikey and apisecret

+ (void) setupWithOrgID:(NSString *)organizationID projectId:(NSString *)projectID APIKey:(NSString *)APIKey
              APISecret:(NSString *)APISecret logging:(BOOL)logging eventNum:(int)eventNum {
    NSLog(@"%@",organizationID);
    [self debug:logging];
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithOrgID:organizationID projectId:(NSString *) projectID APIKey:APIKey APISecret:APISecret eventNum:eventNum];
    });
}

- (id)initWithOrgID:(NSString *)organizationID projectId:(NSString *)projectID APIKey:(NSString *)APIKey APISecret:(NSString *)APISecret eventNum:(int)eventNum {
    if (self = [self init]) {
        self.organizationID = organizationID;
        self.projectID = projectID;
        self.eventQueue = [[DSIOEventQueue alloc] initWithSize:eventNum];
        self.api = [[DSIOAPI alloc] initWithKey:APIKey secret:APISecret];

    }
    return self;
}

#pragma mark - Event Handler

- (void)flushEvents {
    [self.eventQueue flushQueue];
}

- (void)genericEvent:(NSMutableDictionary *)eventDetails {
    [self eventHandler:eventDetails];
}

- (void)eventHandler:(NSMutableDictionary *)eventDetails {
    NSMutableDictionary *eventDetailsCopy = [eventDetails mutableCopy];
    [eventDetailsCopy addEntriesFromDictionary:@{@"organization_ids" : @[self.organizationID], @"project_ids" : @[self.projectID]}];
    [self.eventQueue recordEvent:eventDetailsCopy];
    [self checkQueue];
}

+ (id)sharedClient {
    return sharedInstance;
}

- (void)checkQueue {
    if (self.eventQueue.numberOfQueuedEvents >= self.eventQueue.queueLength) {
        DSIOLog(@"Queue is full. %d will be sent to service and flushed.", (int) self.eventQueue.numberOfQueuedEvents);
        [self.api sendEvents:self.eventQueue.getEvents];
        [self flushEvents];
    }
}


#pragma mark - Turn on/off logging

+ (void)debug:(BOOL)showDebugLogs {
    DSIOSetShowDebugLogs(showDebugLogs);
}


@end

