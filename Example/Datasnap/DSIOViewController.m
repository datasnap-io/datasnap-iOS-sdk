//
//  DSIOViewController.m
//  Datasnap
//
//  Created by Layne McIntyre on 06/24/2016.
//  Copyright (c) 2016 Layne McIntyre. All rights reserved.
//
#import "DSIOViewController.h"

@implementation ViewController
- (void)viewDidLoad
{
    //single instance of Datasnap
    self.datasnap = [Datasnap sharedClient];
    [super viewDidLoad];
}
- (IBAction)beaconSightingButtonTouched:(id)sender
{
    //initialize beacon
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"
                                                   uuid:@"example uuid"
                                                   name:@"example name"
                                           batterylevel:@"example battery level"
                                            temperature:@"example temperature"
                                          bleVendorUuid:@"example vendor uuid"
                                            bleVendorId:@"example vendor ID"
                                                   rssi:@"example rssi"
                                               latitude:@"70"
                                              longitude:@"70"];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_sighting"
                                                               beacon:beacon
                                                             andPlace:nil];
    //add the beacon event to the event queue
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconArrivalButtonTouched:(id)sender
{
    //initialize beacon
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"
                                                   uuid:@"example uuid"
                                                   name:@"example name"
                                           batterylevel:@"example battery level"
                                            temperature:@"example temperature"
                                          bleVendorUuid:@"example vendor uuid"
                                            bleVendorId:@"example vendor ID"
                                                   rssi:@"example rssi"
                                               latitude:@"70"
                                              longitude:@"70"];
    //initialize place
    Place* place = [[Place alloc] initWithName:@"Home"
                                       address:@"123 Fairy Tale Dr."
                                  andGeofences:nil];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_sighting"
                                                               beacon:beacon
                                                             andPlace:place];
    //track event
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconDepartButtonTouched:(id)sender
{
    //initialize beacon
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"
                                                   uuid:@"example uuid"
                                                   name:@"example name"
                                           batterylevel:@"example battery level"
                                            temperature:@"example temperature"
                                          bleVendorUuid:@"example vendor uuid"
                                            bleVendorId:@"example vendor ID"
                                                   rssi:@"example rssi"
                                               latitude:@"70"
                                              longitude:@"70"];
    //initialize place
    Place* place = [[Place alloc] initWithName:@"Home"
                                       address:@"123 Fairy Tale Dr."
                                  andGeofences:nil];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_depart"
                                                               beacon:beacon
                                                             andPlace:place];
    //track event
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)geofenceDepartButtonTouched:(id)sender
{
    //initialize location
    Location* location = [[Location alloc] initWithCoordinates:@[ @"70", @"70" ]];
    //initialize geofence circle
    GeofenceCircle* geofenceCircle = [[GeofenceCircle alloc] initWithRadius:@"60ft"
                                                                andLocation:location];
    //initialize geofence
    Geofence* geofence = [[Geofence alloc] initWithName:@"Home"
                                             identifier:@"example identifier"
                                      andGeofenceCircle:geofenceCircle];
    //initialize geofence event
    GeoFenceEvent* geoFenceEvent = [[GeoFenceEvent alloc] initWithEventType:@"geofence_depart"
                                                                   geoFence:geofence
                                                                andLocation:location];
    //track event
    [self.datasnap trackEvent:geoFenceEvent];
}
- (IBAction)optInLocationButtonTouched:(id)sender
{
    //initialize base event with type opt_in_location
    BaseEvent* event = [[BaseEvent alloc] initWithEventType:@"opt_in_location"];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)optInPushNotificationButtonTouched:(id)sender
{
    //inialize base event with type opt_in_push_notifications
    BaseEvent* event = [[BaseEvent alloc] initWithEventType:@"opt_in_push_notifications"];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)optInVendorButtonTouched:(id)sender
{
    //initialize base event with type opt_in_vendor
    BaseEvent* event = [[BaseEvent alloc] initWithEventType:@"opt_in_vendor"];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)statusPingButtonTouched:(id)sender
{
    //initialize base event with type status_ping
    BaseEvent* event = [[BaseEvent alloc] initWithEventType:@"status_ping"];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)communicationOpenButtonTouched:(id)sender
{
    //initialize content of communication
    Content* content = [[Content alloc] initWithText:@"This is the text"
                                               image:@"sample image"
                                                html:@"sample html"
                                              andUrl:@"google.com"];
    //initialize communication
    Communication* communication = [[Communication alloc] initWithDescription:@"example communication"
                                                                   identifier:@"example identifier"
                                                                         name:@"Title"
                                                                      content:content
                                                                       status:@"example status"
                                                        communicationVendorId:@"example vendor id"];
    //initialize campaign
    Campaign* campaign = [[Campaign alloc] initWithName:@"Advertising campaign"
                                             identifier:@"example identifier"
                                       communicationIds:@"example communication id"];
    //initialize communication event
    CommunicationEvent* event = [[CommunicationEvent alloc] initWithEventType:@"ds_communication_open"
                                                                communication:communication
                                                                     campaign:campaign
                                                                   venueOrgId:@"example venue id"
                                                                customerOrgId:@"example org id"];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)communicationSentButtonTouched:(id)sender
{
    //initialize content of communication
    Content* content = [[Content alloc] initWithText:@"Sample text"
                                               image:@"image name"
                                                html:@"html"
                                              andUrl:@"google.com"];
    //initialize communication
    Communication* communication = [[Communication alloc] initWithDescription:@"example communication"
                                                                   identifier:@"example identifier"
                                                                         name:@"Title"
                                                                      content:content
                                                                       status:@"example status"
                                                        communicationVendorId:@"example vendor id"];
    //initialize campaign
    Campaign* campaign = [[Campaign alloc] initWithName:@"Advertising campaign"
                                             identifier:@"example identifier"
                                       communicationIds:@"example communication id"];
    //initialize communication event
    CommunicationEvent* event = [[CommunicationEvent alloc] initWithEventType:@"ds_communication_sent"
                                                                communication:communication
                                                                     campaign:campaign
                                                                   venueOrgId:@"example venue id"
                                                                customerOrgId:@"example org id"];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)userUpdateButtonTouched:(id)sender
{
    //initialize beacon
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"
                                                   uuid:@"example uuid"
                                                   name:@"example name"
                                           batterylevel:@"example battery level"
                                            temperature:@"example temperature"
                                          bleVendorUuid:@"example vendor uuid"
                                            bleVendorId:@"example vendor ID"
                                                   rssi:@"example rssi"
                                               latitude:@"70"
                                              longitude:@"70"];
    //initialize place
    Place* place = [[Place alloc] initWithName:@"Home"
                                       address:@"123 Fairy Tale Dr."
                                  andGeofences:nil];
    //initialize update event
    UpdateEvent* event = [[UpdateEvent alloc] initWithEventType:@"user_update"
                                                         beacon:beacon
                                                       andPlace:place];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)globalPositionSightingButtonTouched:(id)sender
{
    //initialize location
    Location* location = [[Location alloc] initWithCoordinates:@[ @"coordinate 1", @"coordinate 2" ]];
    //initialize global position
    GlobalPosition* globalPosition = [[GlobalPosition alloc] initWithLocation:location
                                                                     altitude:@"10,000 ft"
                                                                   identifier:@"Example identifier"];
    //initialize global position event
    GlobalPositionEvent* event = [[GlobalPositionEvent alloc] initWithEventType:@"global_position_sighting"
                                                              andGlobalPosition:globalPosition];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)appInstalledButtonTouched:(id)sender
{
    //initialize event with type app_installed
    BaseEvent* event = [[BaseEvent alloc] initWithEventType:@"app_installed"];
    //track event
    [self.datasnap trackEvent:event];
}

@end
