//
//  DSIOGEvent+Management.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEvent+Management.h"

@implementation DSIOEventEntity (Management)
+ (DSIOEventEntity*)createEventEntityInContext:(NSManagedObjectContext*)context
{
    DSIOEventEntity* event = [NSEntityDescription insertNewObjectForEntityForName:@"DSIOEventEntity"
                                                 inManagedObjectContext:context];
    DSIOCoreDataHelper* coreDataHelper = [DSIOCoreDataHelper sharedManager];
    [coreDataHelper saveInContext:coreDataHelper.context];
    return event;
}
+ (DSIOEventEntity*)createEventEntity
{
    DSIOCoreDataHelper* coreDataHelper = [DSIOCoreDataHelper sharedManager];
    return [self createEventEntityInContext:coreDataHelper.context];
}
+ (NSMutableArray*)returnAllEventsInContext:(NSManagedObjectContext*)context
{
    NSMutableArray* eventsArray;
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"DSIOEventEntity"
                                              inManagedObjectContext:context];

    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError* error;
    eventsArray = [[context executeFetchRequest:request error:&error] mutableCopy];
    return eventsArray;
}
+ (NSMutableArray*)returnAllEvents
{
    DSIOCoreDataHelper* coreDataHelper = [DSIOCoreDataHelper sharedManager];
    return [[self class] returnAllEventsInContext:coreDataHelper.context];
}
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray
{
    DSIOCoreDataHelper* coreDataHelper = [DSIOCoreDataHelper sharedManager];
    [[self class] deleteAllEvents:eventsArray inContext:coreDataHelper.context];
}
+ (void)deleteAllEvents:(NSMutableArray*)eventsArray inContext:(NSManagedObjectContext*)context
{
    DSIOCoreDataHelper* coreDataHelper = [DSIOCoreDataHelper sharedManager];
    for (int i = 0; i < eventsArray.count; i++) {
        [context deleteObject:eventsArray[i]];
    }
    [eventsArray removeAllObjects];
    [coreDataHelper saveInContext:context];
}
@end
