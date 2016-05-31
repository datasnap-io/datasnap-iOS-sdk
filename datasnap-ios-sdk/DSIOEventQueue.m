//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//

//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//

#import "DSIOEventQueue.h"

@interface DSIOEventQueue ()

@property NSMutableArray* eventQueue;
@property Event* event;

@end

@implementation DSIOEventQueue

- (id)initWithSize:(NSInteger)queueLength
{
    if (self = [self init]) {
        self.queueLength = queueLength;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.eventQueue = [NSMutableArray new];
    }
    return self;
}

- (void)recordEvent:(NSDictionary*)details
{
    NSError* err;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:details options:0 error:&err];
    NSString* myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.event = [Event createEventEntity];
    self.event.json = myString;
}

- (NSArray*)getEvents
{
    NSMutableArray* eventJsonArray = [[NSMutableArray alloc] init];
    NSArray* eventsArray = [Event returnAllEvents];
    for (Event* event in eventsArray) {
        NSError* err;
        NSData* data = [event.json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* response;
        if (data != nil) {
            response = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        }
        [eventJsonArray addObject:response];
    }
    return eventJsonArray;
}

- (void)flushQueue
{
    NSMutableArray* eventsArray = [Event returnAllEvents];
    [Event deleteAllEvents:eventsArray];
}

- (NSInteger)numberOfQueuedEvents
{
    return [Event returnAllEvents].count;
}

@end
