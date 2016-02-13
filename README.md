## datasnap.io iOS SDK

This guide covers:
* Where to download the SDK
* How to install the SDK
* Getting started sending Events

After completing these steps, please see the [datasnap.io API Documentation](http://docs.datasnapio.apiary.io/) for examples showing you how to use the SDK within your iOS app.


### Current Version

[Version 1.0.4](https://github.com/datasnap-io/datasnap-ios-sdk/releases/download/1.0.4/Datasnap.framework-1.0.4.zip)

### Example iOS App

[datasnap.io iOS Sample App](https://github.com/datasnap-io/datasnap-ios-generic-sample)



## Setup
* Download the latest SDK release [here](https://github.com/datasnap-io/datasnap-ios-sdk/releases/download/1.0.4/Datasnap.framework-1.0.4.zip)
* Uncompress Datasnap.framework-*.zip wherever you like to keep libraries
* Drag the Datasnap.framework file into your Xcode project file.
* Ensure Datasnap.framework is included in your Target -> General -> Linked Frameworks and Libraries
  * If it is not included, delete the Datasnap.framework file from the Xcode project and use the + sign under Linked Frameworks and Libraries to add the Datasnap.framework file directly

![Add a framework from the General menu in Xcode 7.2.1](https://github.com/datasnap-io/datasnap-ios-sdk/blob/readme/readme_images/linkedFramework.png "Adding a framework in Xcode 7.2.1")

  * Choose 'Add Other...' and select Datasnap.framework

![Choose Add Other from the Linked Framework Pop Up in Xcode 7.2.1](https://github.com/datasnap-io/datasnap-ios-sdk/blob/readme/readme_images/addFramework.png "Adding a framework in Xcode 7.2.1")



### Configure App Capabilities
datasnap.io requires Location and Bluetooth capabilities. From Target -> Capabilitites -> Background Modes, turn on 'Location Updates' and 'Uses Bluetooth LE accessories'

![Use the background mode menu item in Xcode 7.2. to set bluetooth and location capabilities](https://github.com/datasnap-io/datasnap-ios-sdk/blob/readme/readme_images/backgroundModes.png "Configuring datasnap.io background capabilities in Xcode 7.2.1")



### Include the DataSnap.io Client header

Add this header to whichever source files (.c, .swift) use the datasnap.io SDK. In the [datasnap.io iOS Sample App](https://github.com/datasnap-io/datasnap-ios-generic-sample), this is contained in the [AppDelegate file](https://github.com/datasnap-io/datasnap-ios-generic-sample/blob/master/dataSnapSample/AppDelegate.m).

Include the public header:
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
```


## Creating Events

Events are proximity-triggered actions like departing a beacon or sending a campaign. Add methods for reporting events in your iOS application. Events are used for reporting and measurement in the datasnap.io Dashboard.


### Required Fields

Include these [Required Event Fields](http://docs.datasnapio.apiary.io/#introduction/sending-events/required-event-fields) to successfully post events.



### Example Events

In the [Datasnap.io iOS Sample App](https://github.com/datasnap-io/datasnap-ios-generic-sample), this is contained in the [ViewController file](https://github.com/datasnap-io/datasnap-ios-generic-sample/blob/master/dataSnapSample/ViewController.m).

For more examples, please see the [Event API Documentation](http://docs.datasnapio.apiary.io/#reference/0/example-events).

``` objective-C
/**
 * Example of a beacon arrival
 */
- (void)exampleBeaconArrive {
    NSDictionary *beaconData = @{@"event_type" : @"beacon_arrive",
                                 @"beacon" : @{@"identifier": @"3333333",
                                                @"rssi": -20},
                                 @"user": @{@"id": @{@"global_distinct_id": global_distinct_id}},
                                 @"datasnap": @{@"created": currentDate()}};
    
    [[DSIOClient sharedClient] genericEvent:(NSMutableDictionary *)beaconData];
    [self logToDeviceAndConsole:@"Datasnap Example Beacon Arrival Event"];
}
```



### Including User Information

To provide better insights, include additional User attributes and IDs, some which map to third-party systems.

Please see [Event API: User Properties](http://docs.datasnapio.apiary.io/#introduction/event-properties/property:-user) for more details.





## datasnap.io Backend Status Page

To check on the server status anytime, visit [status.datasnap.io](http://status.datasnap.io/).  We offer the ability to check on our server status at anytime.

Clients who have an API key issued will automatically receive emails anytime downtime occurs.
