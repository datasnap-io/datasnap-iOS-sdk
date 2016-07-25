//
//  GimbalClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseClient.h"
#import "BaseEvent.h"
#import "Beacon.h"
#import "BeaconEvent.h"
#import "Campaign.h"
#import "Communication.h"
#import "CommunicationEvent.h"
#import "Datasnap.h"
#import "DatasnapAPI.h"
#import "Device.h"
#import "EventEntity.h"
#import "EventQueue.h"
#import "GimbalClient.h"
#import "Location.h"
#import "User.h"

@implementation GimbalClient
- (GimbalClient*)initWithVendorProperties:(VendorProperties*)vendorProperties
                           organizationId:(NSString*)organizationId
                                projectId:(NSString*)projectId
{
    self.gimbalApiKey = (NSString*)vendorProperties.gimbalApiKey;
    self.organizationId = (NSString*)organizationId;
    self.projectId = (NSString*)projectId;
    [self startGimbal];
    return self;
}
- (void)startGimbal
{
    @try {
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
    }
    @catch (NSException* classNotFoundException) {
        NSLog(@"Gimbal class not found. Please add the Gimbal pod to your podfile and run pod install");
    }
}
- (void)beaconManager:(GMBLBeaconManager*)manager didReceiveBeaconSighting:(GMBLBeaconSighting*)sighting
{
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:sighting.beacon.identifier name:sighting.beacon.name bleVendorId:sighting.beacon.uuid];
    BeaconEvent* event = [[BeaconEvent alloc] beaconSighting:beacon];
    Datasnap* datasnap = [Datasnap sharedClient];
    [datasnap trackEvent:event];
}
- (NSArray*)communicationManager:(GMBLCommunicationManager*)manager
    presentLocalNotificationsForCommunications:(NSArray*)communications
                                      forVisit:(GMBLVisit*)visit
{
    for (Communication* communication in communications) {
        Communication* dataSnapCommunication = [[Communication alloc] initWithIdentifier:communication.identifier name:communication.name];
        Campaign* campaign = [[Campaign alloc] initWithName:campaign.name identifier:campaign.identifier communicationIds:communication.identifier];
        CommunicationEvent* event = [[CommunicationEvent alloc] communicationSentWithCommunication:dataSnapCommunication campaign:campaign];
        Datasnap* datasnap = [Datasnap sharedClient];
        [datasnap trackEvent:event];
    }
    return communications;
}
- (UILocalNotification*)communicationManager:(GMBLCommunicationManager*)manager
               prepareNotificationForDisplay:(UILocalNotification*)notification
                            forCommunication:(GMBLCommunication*)communication

{
    Communication* datasnapCommunication = [[Communication alloc] initWithIdentifier:communication.identifier name:communication.title];
    Campaign* campaign = [[Campaign alloc] initWithName:campaign.name identifier:campaign.identifier communicationIds:communication.identifier];
    CommunicationEvent* event = [[CommunicationEvent alloc] communicationOpenWithCommunication:datasnapCommunication campaign:campaign];
    Datasnap* datasnap = [Datasnap sharedClient];
    [datasnap trackEvent:event];
    return notification;
}

@end
