//
//  GimbalClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Beacon.h"
#import "Campaign.h"
#import "Communication.h"
#import "Datasnap.h"
#import "Device.h"
#import "DeviceInfo.h"
#import "EventEntity.h"
#import "GimbalClient.h"
#import "Location.h"
#import "Place.h"
#import "User.h"
static NSString* beaconSightingEventType = @"beacon_sighting";
static NSString* communicationSentEventType = @"ds_communication_sent";
static NSString* communicationOpenEventType = @"ds_communication_open";
@implementation GimbalClient

- (void)startGimbal
{
    [Gimbal setAPIKey:self.gimbalApiKey options:nil];
    [Gimbal start];
    self.beaconManager = [GMBLBeaconManager new];
    self.beaconManager.delegate = self;
    [self.beaconManager startListening];
    self.communicationManager = [GMBLCommunicationManager new];
    self.communicationManager.delegate = self;
    [GMBLPlaceManager startMonitoring];
    [GMBLCommunicationManager startReceivingCommunications];
    BaseClient* baseClient = [[BaseClient alloc] init];
    [baseClient dsioBaseClient];
}
- (void)beaconManager:(GMBLBeaconManager*)manager didReceiveBeaconSighting:(GMBLBeaconSighting*)sighting
{
    NSString* eventType = beaconSightingEventType;
    Beacon* beacon = [[Beacon alloc] init];
    beacon.identifier = sighting.beacon.identifier;
    beacon.rssi = sighting.beacon.uuid;
    beacon.batteryLevel = [NSString stringWithFormat:@"%ld", (long)sighting.beacon.batteryLevel];
    beacon.name = sighting.beacon.name;
    beacon.bleVendorId = @"Gimbal";
    self.user.identifier.globalDistinctId = self.global_distinct_id;
    self.user.identifier.mobileDeviceIosIdfa = self.mobile_device_ios_idfa;
    BeaconEvent* event = [[BeaconEvent alloc] init];
    event.eventType = eventType;
    [event.organizationIds addObject:self.organizationId];
    [event.projectIds addObject:self.projectId];
    event.beacon = beacon;
    event.user = self.user;
    event.deviceInfo = self.deviceInfo;
    NSLog(@"Beacon sighting");
    NSLog(@"%@", sighting.beacon.identifier);
    Datasnap* datasnap = [Datasnap sharedClient];
    [datasnap trackEvent:event];
}

- (NSArray*)communicationManager:(GMBLCommunicationManager*)manager
    presentLocalNotificationsForCommunications:(NSArray*)communications
                                      forVisit:(GMBLVisit*)visit
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    for (Communication* communication in communications) {
        Communication* dataSnapCommunication = [[Communication alloc] init];
        dataSnapCommunication.identifier = communication.identifier;
        dataSnapCommunication.title = communication.title;
        dataSnapCommunication.description = communication.description;
        Campaign* campaign = [[Campaign alloc] init];
        campaign.identifier = self.projectId;
        campaign.communicationIds = communication.identifier;
        NSString* venueId = visit.visitID;
        self.user.identifier.globalDistinctId = self.global_distinct_id;
        self.user.identifier.mobileDeviceIosIdfa = self.mobile_device_ios_idfa;
        CommunicationEvent* event = [[CommunicationEvent alloc] init];
        event.eventType = communicationSentEventType;
        [event.organizationIds addObject:self.organizationId];
        [event.projectIds addObject:self.projectId];
        event.venueOrgId = venueId;
        event.customerVenueOrgId = venueId;
        event.user = self.user;
        event.communication = dataSnapCommunication;
        event.campaign = campaign;
        Datasnap* datasnap = [Datasnap sharedClient];
        [datasnap trackEvent:event];
    }
    return communications;
}

- (UILocalNotification*)communicationManager:(GMBLCommunicationManager*)manager
               prepareNotificationForDisplay:(UILocalNotification*)notification
                            forCommunication:(GMBLCommunication*)communication

{
    Communication* dataSnapCommunication = [[Communication alloc] init];
    dataSnapCommunication.identifier = communication.identifier;
    dataSnapCommunication.title = communication.title;
    dataSnapCommunication.description = communication.description;
    Campaign* campaign = [[Campaign alloc] init];
    campaign.identifier = self.projectId;
    campaign.communicationIds = communication.identifier;
    self.user.identifier.globalDistinctId = self.global_distinct_id;
    self.user.identifier.mobileDeviceIosIdfa = self.mobile_device_ios_idfa;
    CommunicationEvent* event = [[CommunicationEvent alloc] init];
    event.eventType = communicationSentEventType;
    [event.organizationIds addObject:self.organizationId];
    [event.projectIds addObject:self.projectId];
    event.user = self.user;
    event.communication = dataSnapCommunication;
    event.campaign = campaign;
    Datasnap* datasnap = [Datasnap sharedClient];
    [datasnap trackEvent:event];
    return notification;
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if (application.applicationState == UIApplicationStateInactive) {

        //app is transitioning from background to foreground (user taps notification), do what you need when user taps here
    }
}
@end
