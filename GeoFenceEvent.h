//
//  GeoFenceEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "DSIOGeofence.h"
#import "DSIOPlace.h"
#import <Foundation/Foundation.h>

@interface GeoFenceEvent : BaseEvent
@property DSIOGeofence* geofence;
@property DSIOLocation* location;
@end
