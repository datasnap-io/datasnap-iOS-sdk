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
    self.datasnap = [Datasnap sharedClient];
}
- (IBAction)beaconSightingButtonTouched:(id)sender
{
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] init];
    beaconEvent.eventType = @"beacon_sighting";
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconArrivalButtonTouched:(id)sender
{
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] init];
    beaconEvent.eventType = @"beacon_sighting";
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconDepartButtonTouched:(id)sender
{
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] init];
    beaconEvent.eventType = @"beacon_depart";
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)geofenceDepartButtonTouched:(id)sender
{
    GeoFenceEvent* geoFenceEvent = [[GeoFenceEvent alloc] init];
    geoFenceEvent.eventType = @"geofence_depart";
    [self.datasnap trackEvent:geoFenceEvent];
}

@end
