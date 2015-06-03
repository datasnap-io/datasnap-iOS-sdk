## Datasnap iOS SDK
* Includes a sample app that shows sending proximity events
* See details about event types here: http://docs.datasnapio.apiary.io/
* The SDK stores events in memory before flushing to the Datasnap server

## Current Version

[Version 1.0.3](https://github.com/datasnap-io/datasnap-ios-sdk/releases/download/1.0.3/Datasnap.framework-1.0.3.zip)

## Setup
In order to integrate the Datasnap SDK with your application
* Download the latest binary and public headers [here](https://github.com/datasnap-io/datasnap-ios-sdk/releases/download/1.0.3/Datasnap.framework-1.0.3.zip)
* Uncompress Datasnap.framework-*.zip. It should contain: Datasnap.framework
* Drag and drop Datasnap.framework into your XCode project
* Ensure Datasnap.framework is included in your Target -> General -> Linked Frameworks and Libraries

## iOS Quick Start

Integrating Datasnap.io with an iOS application? Check out the [Datasnap.io iOS Sample App](https://github.com/datasnap-io/datasnap-ios-generic-sample) to get started, then check back here for more detailed documentation.

### Include the DataSnap.io Client header

Include the public header
```objective-C
#import <Datasnap/DSIOClient.h>
```

Then instantiate a client and use the created sharedClient throughout your application.

```objective-C

    [DSIOClient setupWithOrgID:@"org-id-provided-by-datasnap"
                     projectId:@"YourTestApplication"
                        APIKey:@"api-key-provided-by-datasnap"
                     APISecret:@"api-secret-provided-by-datasnap"
                       logging:true
                      eventNum:15];

    NSDictionary *event = @{@"event_type" : @"beacon_sighting",
                                 @"beacon" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

```

## Example events to fill Datasnap.io Default Dashboard

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


    NSDictionary *event = @{@"event_type" : @"beacon_sighting",
                                 @"beacon" : @{@"identifier": @"3333333",
                                               @"name": @"Entrance Beacon"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

```


### Beacon Widget and Beacon Heat Mapping

Events:  beacon_sighting, beacon_depart, beacon_arrive 

```objective-C


    NSDictionary *event = @{@"event_type" : @"beacon_sighting",
                                 @"beacon" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

```

### Place Pathing

Events:  beacon_sighting, beacon_depart, beacon_arrive 

If you send Beacon events above there is nothing you need ot do here is you have used our Entity API to add places and beacons or you have autoupdate turned on.  See: http://docs.datasnapioentityapi.apiary.io/#

### Place events

Events:  place_depart, place_arrive 

These are currently not used for any particular widget in the default dashboard

```objective-C


    NSDictionary *event = @{@"event_type" : @"place_arrive",
                                 @"place" : @{@"id": @"3333333",
                                               @"name": @"Entrance Beacon"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

```

### Campaign Reporting

events: ds_communication_sent ds_communication_open 

```objective-C


    NSDictionary *event = @{@"event_type" : @"ds_communication_sent",
                                 @"campaign" : @{@"identifier": @"3333333",
                                                @"status": @"foreground"},
                                 @"communication" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

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


    NSDictionary *event = @{@"event_type" : @"geofence_depart",
                                 @"geofence" : @{@"identifier": @"3333333"},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

```

### GPS Reporting Widget

events: global_position_sighting  

```objective-C


   NSDictionary *event = @{@"event_type" : @"global_position_sighting",
                                 @"location" : @{@"coordinates" : @[@"32.89545949009762, -117.19463284827117"]},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)event];

```


## Datasnap.io Backend Status Page

We offer the ability to check on our server status at anytime. Also if you are a client and we have issued you an API key then that means that
we will email you of any downtime as soon as it occurs:

http://status.datasnap.io/
