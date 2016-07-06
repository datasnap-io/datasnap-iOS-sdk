//
//  DSIOGEvent+Management.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Event+Management.h"

@implementation EventEntity (Management)
+ (EventEntity*)createEventEntityInContext:(NSManagedObjectContext*)context
{
    EventEntity* event = [NSEntityDescription insertNewObjectForEntityForName:@"EventEntity"
                                                 inManagedObjectContext:context];
    CoreDataHelper* coreDataHelper = [CoreDataHelper sharedManager];
    [coreDataHelper saveInContext:coreDataHelper.context];
    return event;
}
+ (EventEntity*)createEventEntity
{
    CoreDataHelper* coreDataHelper = [CoreDataHelper sharedManager];
    return [self createEventEntityInContext:coreDataHelper.context];
}
+ (NSMutableArray*)returnAllEventsInContext:(NSManagedObjectContext*)context
{
    NSMutableArray* eventsArray;
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"EventEntity"
                                              inManagedObjectContext:context];

    NSFetchRequest* request = [NSFetchRequest new];
    [request setEntity:entity];
    NSError* error;
    eventsArray = [[context executeFetchRequest:request error:&error] mutableCopy];
    return eventsArray;
}
+ (NSMutableArray*)returnAllEvents
{
    CoreDataHelper* coreDataHelper = [CoreDataHelper sharedManager];
    return [[self class] returnAllEventsInContext:coreDataHelper.context];
}
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray
{
    CoreDataHelper* coreDataHelper = [CoreDataHelper sharedManager];
    [self  deleteAllEvents:eventsArray inContext:coreDataHelper.context];
}
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray inContext:(NSManagedObjectContext*)context
{
    CoreDataHelper* coreDataHelper = [CoreDataHelper sharedManager];
    for (int i = 0; i < eventsArray.count; i++) {
        [context deleteObject:eventsArray[i]];
    }
    [eventsArray removeAllObjects];
    [coreDataHelper saveInContext:context];
}
@end
