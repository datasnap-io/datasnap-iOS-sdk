//
//  GeoFence.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "GeofenceCircle.h"
#import "Tags.h"

@interface Geofence : EventProperty
@property NSString* name;
@property NSString* visibility;
@property Tags* tags;
@property GeofenceCircle* geofenceCircle;

- (Geofence*)initWithName:(NSString*)name
               visibility:(NSString*)visibility
                     tags:(Tags*)tags
        andGeofenceCircle:(GeofenceCircle*)geofenceCircle;
@end
