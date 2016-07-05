//
//  EventQueueSpec.m
//  Datasnap
//
//  Created by Alyssa McIntyre on 7/1/16.
//  Copyright © 2016 Layne McIntyre. All rights reserved.
//
#import "Datasnap.h"
#import "Event+Management.h"
#import "VendorProperties.h"
#import <Kiwi/Kiwi.h>
#import <MagicalRecord/MagicalRecord.h>

SPEC_BEGIN(EventQueueSpec)
describe(@"Datasnap API",
    ^{
        __block NSManagedObjectContext* context = nil;
        __block Datasnap* datasnap = nil;
        __block EventQueue* eventQueue = nil;
        __block EventEntity* event = nil;
        __block NSDictionary* jsonDict = nil;
        beforeEach(^{

            // Set up Core Data entities for the categories tests.
            [MagicalRecord setDefaultModelFromClass:[BaseEvent class]];
            [MagicalRecord setupCoreDataStackWithInMemoryStore];
            context = [NSManagedObjectContext MR_defaultContext];
            jsonDict = @{ @"event_type" : @"app_installed",
                @"user" : @{ @"id" : @{ @"global_distinct_id" : @"1" } },
                @"organization_ids" : @[ @"19CYxNMSQvfnnMf1QS4b3Z" ],
                @"project_ids" : @[ @"21213f8b-8341-4ef3-a6b8-ed0f84945186" ]
            };
            event = [EventEntity createEventEntityInContext:context];
            event.json = [NSString stringWithFormat:@"%@", jsonDict];
            datasnap = [Datasnap new];
            eventQueue = [EventQueue new];
            [eventQueue stub:@selector(init) andReturn:eventQueue];
            eventQueue.context = context;
            eventQueue.queueLength = 2;
        });
        afterEach(^{
            [MagicalRecord cleanUp];
        });
        it(@"Should get two events", ^{
            EventEntity* event2 = [EventEntity createEventEntityInContext:context];
            event2.json = [NSString stringWithFormat:@"%@", jsonDict];
            EventEntity* event3 = [EventEntity createEventEntityInContext:context];
            event3.json = [NSString stringWithFormat:@"%@", jsonDict];
            NSArray* eventsArray = [EventEntity returnEventsInBatchSize:eventQueue.queueLength
                                                             andContext:context];
            [[theValue(eventsArray.count) should] equal:theValue(2)];
        });
        it(@"Should flush two events", ^{
            [EventEntity createEventEntityInContext:context];
            NSMutableArray* eventArray = [EventEntity returnAllEventsInContext:context];
            [eventQueue flushQueue:eventArray];
            eventArray = [EventEntity returnAllEventsInContext:context];
            [[theValue(eventArray.count) should] equal:theValue(0)];
        });
    });

SPEC_END
