//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//
#import "DSIOClient.h"
#import "DSIOEventQueue.h"
#import "DSIORequest.h"
#import "DSIOConfig.h"

static DSIOClient *sharedInstance = nil;
static int eventQueueSize = 20;
static NSString *__organizationID;
static NSString *__projectID;

@implementation NSMutableDictionary (AddNotNil)

- (void)addNotNilEntriesFromDictionary:(NSDictionary *)otherDictionary {
    if (otherDictionary) {
        [self addEntriesFromDictionary:otherDictionary];
    }
}

@end

@interface DSIOClient ()

@property DSIOEventQueue *eventQueue;
@property DSIORequest *requestHandler;
@property NSString *organizationID;
@property NSString *projectID;

- (void)checkQueue;

@end

@implementation DSIOClient

#pragma mark - Init the SDK with org id, project id, apikey and apisecret

+ (void) setupWithOrgID:(NSString *)organizationID projectId:(NSString *)projectID APIKey:(NSString *)APIKey
              APISecret:(NSString *)APISecret logging:(BOOL)logging eventNum:(int)eventNum {
    [self debug:logging];
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithOrgID:organizationID projectId:(NSString *) projectID APIKey:APIKey APISecret:APISecret eventNum:eventNum];
    });
}

- (id)initWithOrgID:(NSString *)organizationID projectId:(NSString *)projectID APIKey:(NSString *)APIKey APISecret:(NSString *)APISecret eventNum:(int)eventNum {
    if (self = [self init]) {
        __organizationID = organizationID;
        __projectID = projectID;
        eventQueueSize = eventNum;
        NSData *authData = [[NSString stringWithFormat:@"%@:%@", APIKey, APISecret] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authString = [authData base64EncodedStringWithOptions:0];
        self.eventQueue = [[DSIOEventQueue alloc] initWithSize:eventQueueSize];
        self.requestHandler = [[DSIORequest alloc] initWithURL:@"https://api-events.datasnap.io/v1.0/events" authString:authString];
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
    [eventDetailsCopy addEntriesFromDictionary:@{@"organization_ids" : @[__organizationID], @"project_ids" : @[__projectID]}];
    [self.eventQueue recordEvent:eventDetailsCopy];
    [self checkQueue];
}

+ (id)sharedClient {
    return sharedInstance;
}

- (void)checkQueue {
    if (self.eventQueue.numberOfQueuedEvents >= self.eventQueue.queueLength) {
        DSIOLog(@"Queue is full. %d will be sent to service and flushed.", (int) self.eventQueue.numberOfQueuedEvents);
        [self.requestHandler sendEvents:self.eventQueue.getEvents];
        [self flushEvents];
    }
}


#pragma mark - Turn on/off logging

+ (void)debug:(BOOL)showDebugLogs {
    DSIOSetShowDebugLogs(showDebugLogs);
}


@end

