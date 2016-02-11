## datasnap.io iOS SDK

This guide covers
* Where to download the SDK
* How to install the SDK

After completing these steps, please see the **[datasnap.io API Documentation](http://docs.datasnapio.apiary.io/)** for examples showing you how to use the SDK within your iOS app.



## Current Version

[Version 1.0.4](https://github.com/datasnap-io/datasnap-ios-sdk/releases/download/1.0.4/Datasnap.framework-1.0.4.zip)

## Example iOS App

[Datasnap.io iOS Sample App](https://github.com/datasnap-io/datasnap-ios-generic-sample)


## Setup
* Download the latest SDK release [here](https://github.com/datasnap-io/datasnap-ios-sdk/releases/download/1.0.4/Datasnap.framework-1.0.4.zip)
* Uncompress Datasnap.framework-*.zip wherever you like to keep libraries
* Drag the Datasnap.framework file into your Xcode project file.
* Ensure Datasnap.framework is included in your Target -> General -> Linked Frameworks and Libraries
** If it is not, delete the Datasnap.framework file from the Xcode project and use the + sign under Linked Frameworks and Libraries to add the Datasnap.framework file directly
![Add a framework from the General menu in Xcode 7.2.1](https://github.com/datasnap-io/datasnap-ios-sdk/readme_images/addFramework.png "Adding a framework in Xcode 7.2.1")
** Choose 'Add Other...' and select Datasnap.framework
![Choose Add Other from the Linked Framework Pop Up in Xcode 7.2.1](https://github.com/datasnap-io/datasnap-ios-sdk/readme_images/linkedFramework.png "Adding a framework in Xcode 7.2.1")


## Configure App Capabilities
datasnap.io requires Location and Bluetooth capabilities. From Target -> Capabilitites -> Background Modes, turn on 'Location Updates' and 'Uses Bluetooth LE accessories'
![Use the background mode menu item in Xcode 7.2. to set bluetooth and location capabilities](https://github.com/datasnap-io/datasnap-ios-sdk/readme_images/backgroundModes.png "Configuring datasnap.io background capabilities in Xcode 7.2.1")


## iOS Quick Start

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
                            @"datasnap": @{@"created": currentDate()},
                            @"venue_org_id": @"MarksSuperCoolVenueID"};
    
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



## Datasnap.io Backend Status Page

We offer the ability to check on our server status at anytime. Also if you are a client and we have issued you an API key then that means that
we will email you of any downtime as soon as it occurs:

http://status.datasnap.io/
