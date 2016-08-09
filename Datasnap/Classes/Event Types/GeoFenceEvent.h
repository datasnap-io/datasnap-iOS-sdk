//
//  GeoFenceEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Geofence.h"

@interface GeoFenceEvent : BaseEvent
@property Geofence* geofence;
- (GeoFenceEvent*)geofenceDepart:(Geofence*)geofence;
@end
