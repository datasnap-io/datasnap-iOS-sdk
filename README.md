## Datasnap iOS SDK
====================
* Includes a sample app that shows sending proximity events
* See details about event types here: http://docs.datasnapio.apiary.io/
* The SDK stores events in memory before flushing to the Datasnap server

## Current Version
==================

Version 1.0.1

[Version 1.0.1](releases/DSIOClient-1.0.1.zip)

## Setup
=====
In order to integrate the Datasnap SDK with your application
* Drag and drop the DSClient framework into your XCode project
* Ensure DSIOClient.framework is included in your Target -> General -> Linked Frameworks and Libraries
* Ensure DSIOClient.framework is included in your Target -> General -> Embedded Binaries

## iOS Quick Start

Integrating Datasnap.io with an iOS application? Check out the [Datasnap.io iOS Sample App](https://github.com/datasnap-io/datasnap-ios-generic-sample) to get started, then check back here for more detailed documentation.

## Example:

You will notice that our SDK is pretty dumb and does NOT try to itself pull information about the device with our SDK.

We do include organziation and projects IDs after regestering with the DataSnap.io client

```objective-C

    [DSIOClient setupWithOrgID:@"org-id-provided-by-datasnap"
                     projectId:@"YourTestApplication"
                        APIKey:@"api-key-provided-by-datasnap"
                     APISecret:@"api-secret-provided-by-datasnap"
                       logging:true
                      eventNum:15];

    NSDictionary *beaconData = @{@"event_type" : @"beacon_sighting",
                                 @"beacon" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];

```

## Datasnap.io Backend Status Page

We offer the ability to check on our server status at anytime. Also if you are a client and we have issued you an API key then that means that
we will email you of any downtime as soon as it occurs:

http://status.datasnap.io/

