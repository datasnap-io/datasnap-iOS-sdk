//
//  DSIOGEvent+Management.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOCoreDataHelper.h"
#import "DSIOEventEntity.h"

@interface DSIOEventEntity (Management)
+ (DSIOEventEntity*)createEventEntityInContext:(NSManagedObjectContext*)context;
+ (DSIOEventEntity*)createEventEntity;
+ (NSMutableArray*)returnAllEvents;
+ (NSMutableArray*)returnAllEventsInContext:(NSManagedObjectContext*)context;
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray;
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray inContext:(NSManagedObjectContext*)context;
@end
