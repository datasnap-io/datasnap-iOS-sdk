//
//  DSIOGimbalClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Beacon.h"
#import "Campaign.h"
#import "Communication.h"
#import "DSIOGimbalClient.h"
#import "DataSnap.h"
#import "Device.h"
#import "DeviceInfo.h"
#import "EventEntity.h"
#import "Location.h"
#import "Place.h"
#import "User.h"
@implementation DSIOGimbalClient

- (void)startGimbal
{
    [Gimbal setAPIKey:self.gimbalApiKey options:nil];
    [Gimbal start];
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings* mySettings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    self.beaconManager = [GMBLBeaconManager new];
    self.beaconManager.delegate = self;
    [self.beaconManager startListening];
    self.communicationManager = [GMBLCommunicationManager new];
    self.communicationManager.delegate = self;
    [GMBLPlaceManager startMonitoring];
    [GMBLCommunicationManager startReceivingCommunications];
    DSIOBaseClient* baseClient = [[DSIOBaseClient alloc] init];
    [baseClient dsioBaseClient];
}
- (void)beaconManager:(GMBLBeaconManager*)manager didReceiveBeaconSighting:(GMBLBeaconSighting*)sighting
{
    NSString* eventType = @"beacon_sighting";
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
    DataSnap* datasnap = [DataSnap sharedClient];
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
        event.eventType = @"ds_communication_sent";
        [event.organizationIds addObject:self.organizationId];
        [event.projectIds addObject:self.projectId];
        event.venueOrgId = venueId;
        event.customerVenueOrgId = venueId;
        event.user = self.user;
        event.communication = dataSnapCommunication;
        event.campaign = campaign;
        DataSnap* datasnap = [DataSnap sharedClient];
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
    event.eventType = @"ds_communication_sent";
    [event.organizationIds addObject:self.organizationId];
    [event.projectIds addObject:self.projectId];
    event.user = self.user;
    event.communication = dataSnapCommunication;
    event.campaign = campaign;
    DataSnap* datasnap = [DataSnap sharedClient];
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
