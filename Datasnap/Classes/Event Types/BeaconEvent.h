//
//  BeaconEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Beacon.h"

// Why are we importing this in the header file?
#import <Foundation/Foundation.h>

@interface BeaconEvent : BaseEvent

/*
	All of the deleted properties are declared in BaseEvent.
	Why are we including them in the BeaconEvent interface as well?
*/

@property Beacon* beacon;
- (BeaconEvent*)beaconSighting:(Beacon*)beacon;
- (BeaconEvent*)beaconDepart:(Beacon*)beacon;
- (BeaconEvent*)beaconArrive:(Beacon*)beacon;

@end
