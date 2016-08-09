//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//
#import "CoreDataHelper.h"
#import "Event+Management.h"
#import <Foundation/Foundation.h>

@interface EventQueue : NSObject

/**
 Number of events to batch
 */
@property NSInteger queueLength;
@property NSInteger queueTime;
@property NSInteger maxQueueLength;
@property NSManagedObjectContext* context;
@property NSMutableArray* eventsArray;
/**
 Create event queue
 */
- (id)initWithSize:(NSInteger)queueLength
           andTime:(NSInteger)queueTime;

/**
 Record an event
 */
- (void)recordEvent:(NSDictionary*)details;

/**
 Flush all events
 */
- (void)flushQueue:(NSMutableArray*)queue;

/**
 Return events in queue (have not been sent)
 */
- (NSArray*)getEvents;

/**
 Return number of events in queue
 */
- (NSInteger)numberOfQueuedEvents;

@end
