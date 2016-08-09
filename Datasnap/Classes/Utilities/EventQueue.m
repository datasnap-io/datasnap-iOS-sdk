//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//

#import "EventQueue.h"

@interface EventQueue ()

@end

@implementation EventQueue
- (id)initWithSize:(NSInteger)queueLength
           andTime:(NSInteger)queueTime
{
    if (self = [self init]) {
        self.queueLength = queueLength;
        self.queueTime = queueTime;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        CoreDataHelper* coreDataHelper = [CoreDataHelper sharedManager];
        self.context = coreDataHelper.context;
    }
    return self;
}

- (void)recordEvent:(NSDictionary*)details
{
    NSError* err;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:details options:0 error:&err];
    NSString* myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    EventEntity* event = [EventEntity createEventEntityInContext:self.context];
    event.json = myString;
    NSLog(@"Event recorded");
}

- (NSArray*)getEvents
{
    NSMutableArray* eventJsonArray = [NSMutableArray new];
    self.eventsArray = [EventEntity returnEventsInBatchSize:self.queueLength
                                                 andContext:self.context];
    for (EventEntity* event in self.eventsArray) {
        NSError* err;
        NSData* data = [event.json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* response;
        if (data != nil) {
            response = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            [eventJsonArray addObject:response];
        }
    }
    return eventJsonArray;
}

- (void)flushQueue:(NSMutableArray*)queue
{
    for (EventEntity* event in self.eventsArray) {
        [EventEntity deleteEvent:event inContext:self.context];
    }
    [self.eventsArray removeAllObjects];
}

- (NSInteger)numberOfQueuedEvents
{
    return [EventEntity returnAllEvents].count;
}

@end
