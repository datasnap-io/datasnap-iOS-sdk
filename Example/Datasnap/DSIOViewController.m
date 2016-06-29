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
    [super viewDidLoad];
}
- (IBAction)beaconSightingButtonTouched:(id)sender
{
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_sighting"
                                                               beacon:nil
                                                             andPlace:nil];
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconArrivalButtonTouched:(id)sender
{
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_sighting"
                                                               beacon:nil
                                                             andPlace:nil];
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)beaconDepartButtonTouched:(id)sender
{
    BeaconEvent* beaconEvent = [[BeaconEvent alloc] initWithEventType:@"beacon_depart"
                                                               beacon:nil
                                                             andPlace:nil];
    [self.datasnap trackEvent:beaconEvent];
}
- (IBAction)geofenceDepartButtonTouched:(id)sender
{
    GeoFenceEvent* geoFenceEvent = [[GeoFenceEvent alloc] initWithEventType:@"geofence_depart"
                                                                   geoFence:nil
                                                                andLocation:nil];
    [self.datasnap trackEvent:geoFenceEvent];
}

@end
