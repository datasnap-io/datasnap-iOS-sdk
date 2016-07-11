# Intro
The Datasnap.io SDK is designed to make integrating your location-based app with the Datasnap analytics platform simple and painless. 
The simplest way to integrate is to include our library and write a single line of code, as detailed below. Your app should then track location events with no further configuration.
However, if you want to track events programmatically, that can be done as well. 
(what versions of iOS are supported?)

# Version
The current version is [2.0.0](Link to version).  It simplifies the  process of integrating with third-party libraries and it now sends certain user information by default (see What Data is Sent by Default, below).   If your privacy consent with end users does not allow sharing this data with Neustar, you will need to override the default setting (see Identifying User Data, below)

### Version Archive
-[Version 1.0.4](releases/download/1.0.4/Datasnap.framework-1.0.4.zip)
  - [Documentation](wiki/Version-1.0.4-Documentation)


# Setup / integration

If you are doing a generic integration (without activating a specific vendor) use:
`pod ‘Datasnap’`
If you are integrating with the Gimbal beacon library, however, use:
`pod ‘Datasnap/Gimbal’`

Followed by:
`pod install`

Then import the Datasnap header file into your application:
`#import <Datasnap/Datasnap.h>`

Enter a string for `NSLocationAlwaysUsageDescription` in the plist file.  This will be what the user sees when user is asked permission to use location services.


#### Generic Integration
This section illustrates the basic Datasnap integration. It does not include a specific vendor implementation. Therefore it omits the vendorProperties object which is used to configure and activate a specific vendor’s implementation. This integration would be used when you don’t want to use any of the supplied 3rd-party integrations; for example you might choose to capture all events yourself and send them manually to Datasnap (see “Sending Events Programatically”)

```ObjectiveC
Datasnap* datasnap = [Datasnap sharedClient];
datasnap = [datasnap initWithApiKey:@"3F34FXD78PCINSUN75GW950W4"
    apiKeySecret:@"KA0HdzrZzNjvUq8OnKQoxaReyGhdR70ckNYoMZURxK8"
    organizationId:@"19CYxNQSMvfnnMf1QS4b3Z"
    projectId:@"21213f8b-8341-4ef3-a6b8-ed0f86982486"
    googleAdOptIn:YES
    email:@"someemail@example.com"
    andVendorProperties:nil];
[datasnap setFlushParamsWithDuration:100000 withMaxElements:50];
```
Note the `setFlushParamsWithDuration` method call.  This configures the event buffer.  The first parameter is the number of milliseconds before events are sent to the server, the second the number of events that can be collected before they’re sent to the server.  The buffer is flushed when either one of these conditions is met.  This must be called as part of the initialization process, and cannot be reconfigured later.

If you are not using user tracking by hashed email (see Identifying User Data), pass in the parameter `email: nil`.

#### Vendor Integration (Gimbal example)
Most often you will allow the datasnap  SDK to automatically integrate with third-party beacon manufacturers’ libraries.  At the moment, only Gimbal is supported in this way.

```ObjectiveC
VendorProperties* vendorProperties = [[VendorProperties alloc] initWithVendor:GIMBAL andgimbalApiKey:@"74e344e9-9625-4b9d-96cf-e7805479d33c"];

Datasnap* datasnap = [Datasnap sharedClient];
datasnap = [datasnap initWithApiKey:@"3F34FXD78PCINFR99IYW950W4"
    apiKeySecret:@"KA0HdzrZzNjvUq8OnKQoxaReyUayZY0ckNYoMZURxK8"
    organizationId:@"19CYxNMSQvfnnMf1QS4b3Z"
    projectId:@"21213f8b-8341-4ef3-a6b8-ed0f84945186"
    googleAdOptIn:YES
    email:@"someemail@example.com"
    andVendorProperties:vendorProperties];
[datasnap setFlushParamsWithDuration:100000 withMaxElements:50];
```

#### Integrating with Swift

```Swift
let datasnap = Datasnap.sharedClient()
let vendorProperties = VendorProperties(vendor:GIMBAL,
gimbalApiKey:”Enter your Gimbal API key”)
let datasnap = Datasnap(apiKey:”Enter your Datasnap API key here",
                         apiKeySecret:”Enter your Datasnap API secret here",
                       organizationId:”Enter your organization ID here",
                            projectId:”Enter your project ID here”,
                            IDFAOptIn:true,
                                email:"someemail@example.com”,
                  andVendorProperties:vendorProperties)
```


### Sending Events Programatically
Instead of allowing the Datasnap SDK to automatically send events, you can send them manually.  You might do this for testing purposes or if you needed to modify the event content in some way.

In the code below, “self” is used because the datasnap object is a member of the current object. It is not necessary to implement it this way.

```ObjectiveC
//initialize beacon
Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"
                                                   uuid:@"example uuid"
                                                   name:@"example name"
                                           batterylevel:@"example battery level"
                                            temperature:@"example temperature"
                                          bleVendorUuid:@"example vendor uuid"
                                            bleVendorId:@"example vendor ID"
                                                   rssi:@"example rssi"
                                               isMobile:@"yes"
                                           previousRssi:nil
                                              dwellTime:@"2 hours"
                                              startTime:@"2:40pm"
                                         lastUpdateTime:@"1:20pm"
                                               latitude:@"70"
                                              longitude:@"70"
                                             visibility:@"high"
                                               hardware:@"example hardware"
                                                   tags:nil];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_sighting"
                                                               beacon:beacon
                                                             andPlace:nil];
    //add the beacon event to the event queue
    [self.datasnap trackEvent:beaconEvent];
```

## What Data is Sent by Default
By default, the SDK collects a variety of data about the device to aid in statistical analysis.

- IP address
- SDK version
- OS version
- Device model
- Device manufacturer
- Device name
- Device brand
- Carrier name
- IDFA (dependent on user settings)

# Identifying User Data (IDFA/email)
The Datasnap analytics platform can be more useful when events are linked to a unique user identifier.  We can use either Apple's IDFA or the user's email to uniquely identify that user.

The user can disable the use of the IDFA by turning on "Limit Ad Tracking" in Settings >> Privacy.  You, the developer, can also stop the IDFA from being sent to the Datasnap servers by initializing the Datasnap object with the parameter `googleAdOptIn:NO`.

If you wish to use an email, initialize the Datasnap object with `email:@"someemail@example.com"`. The email will be hashed to avoid specifically identifying the user. 

We will only use an identifier, whether email or IDFA, as a means to tie together sequences of events.

## Datasnap.io Backend 

#### Event API

http://docs.datasnapio.apiary.io/#

#### Status Page
We offer the ability to check on our server status at anytime. Also if you are a client and we have issued you an API key then that means that we will email you of any downtime as soon as it occurs:

http://status.datasnap.io/

## License

The Datasnap SDK is available under the Apache 2 license. See the LICENSE file for more info.
