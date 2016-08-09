//
//  BeaconEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BeaconEvent.h"

@implementation BeaconEvent
- (BeaconEvent*)beaconSighting:(Beacon*)beacon
{
    self.beacon = beacon;
    self.event_type = @"beacon_sighting";
    return self;
}
- (BeaconEvent*)beaconDepart:(Beacon*)beacon
{
    self.beacon = beacon;
    self.event_type = @"beacon_depart";
    return self;
}
- (BeaconEvent*)beaconArrive:(Beacon*)beacon
{
    self.beacon = beacon;
    self.event_type = @"beacon_sighting";
    return self;
}
@end
