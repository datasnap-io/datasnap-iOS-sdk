//
//  BeaconEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "DSIOBeacon.h"
#import "DSIODeviceInfo.h"
#import "DSIOEventEntity.h"
#import "DSIOPlace.h"
#import "DSIOUser.h"
#import <Foundation/Foundation.h>

@interface BeaconEvent : BaseEvent
@property DSIOPlace* place;
@property DSIOBeacon* beacon;
@end
