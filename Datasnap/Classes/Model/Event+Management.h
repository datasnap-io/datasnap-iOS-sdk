//
//  DSIOGEvent+Management.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "CoreDataHelper.h"
#import "EventEntity.h"

@interface EventEntity (Management)
+ (EventEntity*)createEventEntityInContext:(NSManagedObjectContext*)context;
+ (EventEntity*)createEventEntity;
+ (NSMutableArray*)returnAllEvents;
+ (NSMutableArray*)returnAllEventsInContext:(NSManagedObjectContext*)context;
+ (NSMutableArray*)returnEventsInBatchSize:(NSInteger)batchSize;
+ (NSMutableArray*)returnEventsInBatchSize:(NSInteger)batchSize
                                andContext:(NSManagedObjectContext*)context;
+ (void)deleteEvent:(EventEntity*)event
          inContext:(NSManagedObjectContext*)context;
+ (void)deleteEvent:(EventEntity*)event;
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray;
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray inContext:(NSManagedObjectContext*)context;
@end
