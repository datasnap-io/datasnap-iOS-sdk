//
//  GeoFenceEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GeoFenceEvent.h"

@implementation GeoFenceEvent
- (GeoFenceEvent*)geofenceDepart:(Geofence*)geofence
{
    self.geofence = geofence;
    self.event_type = @"geofence_depart";
    return self;
}
@end
