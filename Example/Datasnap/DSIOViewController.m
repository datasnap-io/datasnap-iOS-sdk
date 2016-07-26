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
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] beaconSighting:beacon];
    //add the beacon event to the event queue
    self.datasnap.email = @"example updated email";
    self.datasnap.UUID = @"example updated UUID";
    self.datasnap.idfa = @"example updated idfa";
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconArrivalButtonTouched:(id)sender
{
    //initialize beacon
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] beaconArrive:beacon];
    //track event
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconDepartButtonTouched:(id)sender
{
    //initialize beacon
    Beacon* beacon = [[Beacon alloc] initWithIdentifier:@"example identifier"];
    //initialize beacon event
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] beaconDepart:beacon];
    //track event
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)geofenceDepartButtonTouched:(id)sender
{
    //initialize geofence
    Geofence* geofence = [[Geofence alloc] initWithIdentifier:@"example identifier"];
    //initialize geofence event
    GeoFenceEvent* geoFenceEvent = [[GeoFenceEvent alloc] geofenceDepart:geofence];
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
    //initialize communication
    Communication* communication = [[Communication alloc] initWithIdentifier:@"example identifier"
                                                                        name:@"Title"];
    //initialize campaign
    Campaign* campaign = [[Campaign alloc] initWithName:@"Advertising campaign"
                                             identifier:@"example identifier"
                                       communicationIds:@"example communication id"];
    //initialize communication event
    CommunicationEvent* event = [[CommunicationEvent alloc] communicationOpenWithCommunication:communication campaign:campaign];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)communicationSentButtonTouched:(id)sender
{
    //initialize communication
    Communication* communication = [[Communication alloc] initWithIdentifier:@"example identifier"
                                                                        name:@"Title"];
    //initialize campaign
    Campaign* campaign = [[Campaign alloc] initWithName:@"Advertising campaign"
                                             identifier:@"example identifier"
                                       communicationIds:@"example communication id"];
    //initialize communication event
    CommunicationEvent* event = [[CommunicationEvent alloc] communicationOpenWithCommunication:communication campaign:campaign];
    //track event
    [self.datasnap trackEvent:event];
}
- (IBAction)globalPositionSightingButtonTouched:(id)sender
{
    //initialize global position event
    GlobalPositionEvent* event = [[GlobalPositionEvent alloc] globalPositionSighting:@[ @70, @70 ]];
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
- (IBAction)sdkErrorButtonTouched:(id)sender
{
    //initialize event with the type sdk_error
    SDKErrorEvent* event = [[SDKErrorEvent alloc] initWithErrorMessage:@"Sample error message"];
    //track event
    [self.datasnap trackEvent:event];
}

@end
