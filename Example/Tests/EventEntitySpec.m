//
//  EventEntitySpec.m
//  datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/17/16.
//  Copyright © 2016 DataSnap. All rights reserved.
//
#import "Event+Management.h"
#import <Kiwi/Kiwi.h>
#import <MagicalRecord/MagicalRecord.h>

SPEC_BEGIN(EventEntitySpec)
describe(@"EventyEntity Spec",
    ^{
        context(@"Testing internal EventEntity update db methods",
            ^{
                __block NSManagedObjectContext* context = nil;
                __block EventEntity* event = nil;
                beforeEach(^{
                    // Set up Core Data entities for the categories tests.
                    [MagicalRecord setDefaultModelFromClass:[EventEntity class]];
                    [MagicalRecord setupCoreDataStackWithInMemoryStore];
                    context = [NSManagedObjectContext MR_defaultContext];

                    event = [EventEntity createEventEntityInContext:context];
                });
                afterEach(^{
                    [MagicalRecord cleanUp];
                });
                it(@"Should add an event to the database", ^{
                    NSArray* eventsArray = [EventEntity returnAllEventsInContext:context];
                    [[theValue(eventsArray.count) should] equal:theValue(1)];
                });
                it(@"Should delete an event from the database", ^{
                    [EventEntity deleteEvent:event inContext:context];
                    NSArray* eventsArray = [EventEntity returnAllEventsInContext:context];
                    [[theValue(eventsArray.count) should] equal:theValue(0)];
                });
                it(@"Should delete all events from the database", ^{
                    [EventEntity createEventEntityInContext:context];
                    NSMutableArray* eventsArray = [EventEntity returnAllEventsInContext:context];
                    [EventEntity deleteAllEvents:eventsArray inContext:context];
                    eventsArray = [EventEntity returnAllEventsInContext:context];
                    [[theValue(eventsArray.count) should] equal:theValue(0)];
                });
            });
    });

SPEC_END
