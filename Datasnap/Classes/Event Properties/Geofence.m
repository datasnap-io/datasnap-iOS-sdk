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
               visibility:(NSString*)visibility
                     tags:(Tags*)tags
               identifier:(NSString*)identifier
        andGeofenceCircle:(GeofenceCircle*)geofenceCircle
{
    self.name = name;
    self.visibility = visibility;
    self.tags = tags;
    self.identifier = identifier;
    self.geofenceCircle = geofenceCircle;
    return self;
}
@end
