//
//  GeoFenceEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Geofence.h"
#import "Place.h"
#import <Foundation/Foundation.h>

@interface GeoFenceEvent : BaseEvent
@property Geofence* geofence;
@property Location* location;
- (GeoFenceEvent*)initWithEventType:(NSString*)eventType
                           geoFence:(Geofence*)geofence
                        andLocation:(Location*)location;

- (BOOL)isValid;
@end
