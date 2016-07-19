//
//  BeaconEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Beacon.h"

@interface BeaconEvent : BaseEvent
@property Beacon* beacon;
- (BeaconEvent*)beaconSighting:(Beacon*)beacon;
- (BeaconEvent*)beaconDepart:(Beacon*)beacon;
- (BeaconEvent*)beaconArrive:(Beacon*)beacon;

@end
