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

## Example events to fill Daatasnap.io Default Dashboard

Please review this seciton of the documentation and each section below for example code to use to properly populate the core widget in the dashboard.

http://datasnap-io.github.io/pages/apis/#sendingevents

## Global Distinct ID

Global Distinct ID is an important Id that uniquoly identifies a user. also note that you can also send addiitonal IDs to use in mapping to other third party systems.

http://docs.datasnapio.apiary.io/#introduction/event-properties/property:-user

## Required fields

See: http://datasnap-io.github.io/pages/apis/#required

## Autopopulate Beacons/Campaigns

See: http://datasnap-io.github.io/pages/apis/#sendingdata

Typically this means that if you want us to autogetnerate the entities for you also include the name property for each entity.

Example:
```objective-C


    NSDictionary *beaconData = @{@"event_type" : @"beacon_sighting",
                                 @"beacon" : @{@"identifier": @"3333333",
                                               @"name": @"Entrance Beacon"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];

```


### Beacon Widget and Beacon Heat Mapping

Events:  beacon_sighting, beacon_depart, beacon_arrive 

```objective-C


    NSDictionary *beaconData = @{@"event_type" : @"beacon_sighting",
                                 @"beacon" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];

```

### Place Pathing

Events:  beacon_sighting, beacon_depart, beacon_arrive 

If you send Beacon events above there is nothing you need ot do here is you have used our Entity API to add places and beacons or you have autoupdate turned on.  See: http://docs.datasnapioentityapi.apiary.io/#

### Campaign Reporting

events: ds_communication_sent ds_communication_open 

```objective-C


    NSDictionary *beaconData = @{@"event_type" : @"ds_communication_sent",
                                 @"campaign" : @{@"identifier": @"3333333",
                                                @"status": @"foreground"},
                                 @"communication" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];

```
#### Campaign Status

Not the status field to determine if the notification was sent when the app wa sin the foreground or the background.

```
 @"campaign" : @{@"identifier": @"3333333",
                 @"status": @"foreground"},

```

### Geofence Reporting

events: geofence_depart  

```objective-C


    NSDictionary *beaconData = @{@"event_type" : @"geofence_depart",
                                 @"geofence" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];

```

### GPS Reporting Widget

events: geofence_depart  

```objective-C


   NSDictionary *beaconData = @{@"event_type" : @"global_position_sighting",
                                 @"location" : @{@"coordinates" : @[@"32.89545949009762, -117.19463284827117"]},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];

```


## Datasnap.io Backend Status Page

We offer the ability to check on our server status at anytime. Also if you are a client and we have issued you an API key then that means that
we will email you of any downtime as soon as it occurs:

http://status.datasnap.io/

