//
//  DatasnapSpec.m
//  datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/20/16.
//  Copyright © 2016 DataSnap. All rights reserved.
//
#import "Datasnap.h"
#import "Event+Management.h"
#import "VendorProperties.h"
#import <Kiwi/Kiwi.h>
#import <MagicalRecord/MagicalRecord.h>

@interface BaseEvent (UnitTestSupport)
- (id)initWithParentContext:(NSManagedObjectContext*)context;
- (void)updateLastSuccessfulAPISyncForAPI:(NSString*)api withError:(NSError*)error;
- (void)updateLastAttemptedSyncForAPI:(NSString*)api;
@end

SPEC_BEGIN(DatasnapSpec)
describe(@"Datasnap API",
    ^{
        __block NSManagedObjectContext* context = nil;
        __block Datasnap* datasnap = nil;
        __block EventQueue* eventQueue = nil;
        __block DatasnapAPI* apiServer = nil;
        __block NSDictionary* json = nil;
        beforeEach(^{

            // Set up Core Data entities for the categories tests.
            [MagicalRecord setDefaultModelFromClass:[BaseEvent class]];
            [MagicalRecord setupCoreDataStackWithInMemoryStore];
            context = [NSManagedObjectContext MR_defaultContext];

            // Mock the API server
            apiServer = [DatasnapAPI mock];
            [DatasnapAPI stub:@selector(init) andReturn:apiServer];

            //mock json for an event
            json = @{ @"event_type" : @"app_installed",
                @"user" : @{ @"id" : @{ @"global_distinct_id" : @"1" } },
                @"organization_ids" : @[ @"19CYxNMSQvfnnMf1QS4b3Z" ],
                @"project_ids" : @[ @"21213f8b-8341-4ef3-a6b8-ed0f84945186" ]
            };

            // Mock the datasnap server response
            [apiServer stub:@selector(performAuthenticatedRequest:onCompletion:)
                  withBlock:^id(NSArray* params) {
                      DataSnapAPIRequestCompleted completionBlock = params[0];
                      NSURL* url = [[NSURL alloc] initWithString:@"https://api-events-staging.datasnap.io/v1.0/events"];
                      NSURLResponse* response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:nil
                                                                          headerFields:@{ @"Accept-Encoding" : @"gzip",
                                                                              @"Connection" : @"keep-alive",
                                                                              @"Content-Length" : @"4",
                                                                              @"Content-Type" : @"text/plain;charset=UTF-8",
                                                                              @"Date" : @"Tue, 21 Jun 2016 16:48:44 GMT",
                                                                              @"Server" : @"Apache-Coyote/1.1" }];
                      NSError* error;
                      NSData* data = [NSJSONSerialization dataWithJSONObject:json
                                                                     options:NSJSONWritingPrettyPrinted
                                                                       error:&error];
                      completionBlock(data, response, nil);
                      return nil;
                  }];
            datasnap = [Datasnap new];
            datasnap.api = apiServer;
            eventQueue = [EventQueue new];
            [eventQueue stub:@selector(init) andReturn:eventQueue];
            eventQueue.context = context;
        });
        afterEach(^{
            [MagicalRecord cleanUp];
        });
        it(@"Should add an event to db when recorded",
            ^{
                [eventQueue recordEvent:json];
                NSArray* eventsArray = [EventEntity returnAllEventsInContext:context];
                [[theValue(eventsArray.count) should] equal:theValue(1)];
            });
        it(@"Should not call API while offline",
            ^{
                [datasnap stub:@selector(connected) andReturn:theValue(NO)];
                [eventQueue recordEvent:json];
                __block BOOL isAPICalled = NO;
                [apiServer stub:@selector(sendEvents:)
                      withBlock:^id(NSArray* params) {
                          isAPICalled = YES;
                          return nil;
                      }];
                [datasnap checkQueue];
                [[theValue(isAPICalled) should] equal:theValue(NO)];
            });
        it(@"Should call API while online", ^{
            [datasnap stub:@selector(connected) andReturn:theValue(YES)];
            [eventQueue recordEvent:json];
            __block BOOL isAPICalled = NO;
            [apiServer stub:@selector(sendEvents:)
                  withBlock:^id(NSArray* params) {
                      isAPICalled = YES;
                      return nil;
                  }];
            [datasnap checkQueue];
            [[theValue(isAPICalled) should] equal:theValue(YES)];
        });

    });

SPEC_END
