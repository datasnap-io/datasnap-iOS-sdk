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
#import "Campaign.h"
#import "Communication.h"
#import "Communication.h"
#import "CommunicationEvent.h"
#import "Datasnap.h"
#import "DatasnapAPI.h"
#import "Device.h"
#import "EventEntity.h"
#import "EventQueue.h"
#import "GimbalClient.h"
#import "GimbalClient.h"
#import "Location.h"
#import "Place.h"
#import "User.h"

static NSString* beaconSightingEventType = @"beacon_sighting";
static NSString* communicationSentEventType = @"ds_communication_sent";
static NSString* communicationOpenEventType = @"ds_communication_open";
@implementation GimbalClient
- (GimbalClient*)initWithGimbalApiKey:(NSString*)gimbalApiKey
                               device:(Device*)device
                       organizationId:(NSString*)organizationId
                            projectId:(NSString*)projectId
                              andUser:(User*)user
{
    self.gimbalApiKey = gimbalApiKey;
    self.organizationId = organizationId;
    self.projectId = projectId;
    self.user = user;
    self.device = device;
    return self;
}
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
}
- (void)beaconManager:(GMBLBeaconManager*)manager didReceiveBeaconSighting:(GMBLBeaconSighting*)sighting
{
    NSString* eventType = beaconSightingEventType;
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:sighting.beacon.identifier
                                                   uuid:sighting.beacon.uuid
                                                   name:sighting.beacon.name
                                           batterylevel:[NSString stringWithFormat:@"%ld", (long)sighting.beacon.batteryLevel]
                                            temperature:[NSString stringWithFormat:@"%d", sighting.beacon.temperature]
                                          bleVendorUuid:nil
                                            bleVendorId:@"Gimbal"
                                                   rssi:[NSString stringWithFormat:@"%d", sighting.RSSI]
                                               isMobile:nil
                                           previousRssi:nil
                                              dwellTime:nil
                                              startTime:nil
                                         lastUpdateTime:nil
                                               latitude:nil
                                              longitude:nil
                                             visibility:nil
                                               hardware:nil
                                                   tags:nil];
    BeaconEvent* event = [[BeaconEvent alloc] initWithEventType:eventType
                                                         beacon:beacon];
    Datasnap* datasnap = [Datasnap sharedClient];
    [datasnap trackEvent:event];
}
- (NSArray*)communicationManager:(GMBLCommunicationManager*)manager
    presentLocalNotificationsForCommunications:(NSArray*)communications
                                      forVisit:(GMBLVisit*)visit
{
    for (Communication* communication in communications) {
        Communication* dataSnapCommunication = [[Communication alloc] initWithDescription:communication.description
                                                                               identifier:communication.identifier
                                                                                    title:communication.title
                                                                                    types:nil
                                                                                  content:nil
                                                                                   status:nil
                                                                    communicationVendorId:nil
                                                                                  andTags:nil];
        Campaign* campaign = [[Campaign alloc] initWithTitle:nil
                                                  identifier:self.projectId
                                            communicationIds:communication.identifier
                                                     andTags:nil];
        CommunicationEvent* event = [[CommunicationEvent alloc] initWithEventType:@"communicationSentEventType"
                                                                    communication:dataSnapCommunication
                                                                         campaign:campaign
                                                                          venueId:visit.visitID
                                                               customerVenueOrgId:visit.visitID];
        Datasnap* datasnap = [Datasnap sharedClient];
        [datasnap trackEvent:event];
    }
    return communications;
}
- (UILocalNotification*)communicationManager:(GMBLCommunicationManager*)manager
               prepareNotificationForDisplay:(UILocalNotification*)notification
                            forCommunication:(GMBLCommunication*)communication

{
    Communication* dataSnapCommunication = [[Communication alloc] initWithDescription:communication.description
                                                                           identifier:communication.identifier
                                                                                title:communication.title
                                                                                types:nil
                                                                              content:nil
                                                                               status:nil
                                                                communicationVendorId:nil
                                                                              andTags:nil];
    Campaign* campaign = [[Campaign alloc] initWithTitle:nil
                                              identifier:self.projectId
                                        communicationIds:communication.identifier
                                                 andTags:nil];
    CommunicationEvent* event = [[CommunicationEvent alloc] initWithEventType:@"communicationSentEventType"
                                                                communication:dataSnapCommunication
                                                                     campaign:campaign
                                                                      venueId:nil
                                                           customerVenueOrgId:nil];
    Datasnap* datasnap = [Datasnap sharedClient];
    [datasnap trackEvent:event];
    return notification;
}

@end
