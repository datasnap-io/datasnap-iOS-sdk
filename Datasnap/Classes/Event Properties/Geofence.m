//
//  GeoFence.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Geofence.h"

@implementation Geofence

- (Geofence*)initWithName:(NSString*)name
               identifier:(NSString*)identifier
        andGeofenceCircle:(GeofenceCircle*)geofenceCircle
{
    self.name = name;
    self.identifier = identifier;
    self.geofenceCircle = geofenceCircle;
    return self;
}
@end
