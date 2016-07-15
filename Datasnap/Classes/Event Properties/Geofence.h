//
//  GeoFence.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "GeofenceCircle.h"

@interface Geofence : EventProperty
@property NSString* name;
@property GeofenceCircle* geofenceCircle;
@property NSString* identifier;
- (Geofence*)initWithName:(NSString*)name
               identifier:(NSString*)identifier
        andGeofenceCircle:(GeofenceCircle*)geofenceCircle;
@end
