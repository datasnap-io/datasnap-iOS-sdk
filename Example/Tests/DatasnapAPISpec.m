//
//  DatasnapAPISpec.m
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

SPEC_BEGIN(DatasnapAPISpec)
describe(@"Datasnap API",
    ^{
        __block NSManagedObjectContext* context = nil;
        __block Datasnap* datasnap = nil;
        __block EventQueue* eventQueue = nil;
        __block DatasnapAPI* apiServer = nil;
        __block NSDictionary* json = nil;
        __block EventEntity* event = nil;
        beforeEach(^{

            // Set up Core Data entities for the categories tests.
            [MagicalRecord setDefaultModelFromClass:[BaseEvent class]];
            [MagicalRecord setupCoreDataStackWithInMemoryStore];
            context = [NSManagedObjectContext MR_defaultContext];

            // Mock the API server
            apiServer = [DatasnapAPI new];
            [DatasnapAPI stub:@selector(init) andReturn:apiServer];

            //mock json for an event
            event = [EventEntity createEventEntityInContext:context];
            json = @{ @"event_type" : @"app_installed",
                @"user" : @{ @"id" : @{ @"global_distinct_id" : @"1" } },
                @"organization_ids" : @[ @"19CYxNMSQvfnnMf1QS4b3Z" ],
                @"project_ids" : @[ @"21213f8b-8341-4ef3-a6b8-ed0f84945186" ] };
            event.json = [NSString stringWithFormat:@"%@", json];
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
        it(@"Should receive a success message from server", ^{
            NSData* data = [event.json dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableArray* eventJsonArray = [NSMutableArray new];
            NSDictionary* response = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [eventJsonArray addObject:response];
            [apiServer sendEvents:eventJsonArray];
            [[theValue(apiServer.success) should] equal:theValue(YES)];
        });
    });
SPEC_END
