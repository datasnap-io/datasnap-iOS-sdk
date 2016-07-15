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
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
@property User* user;
- (GeoFenceEvent*)initWithEventType:(NSString*)eventType
                           geoFence:(Geofence*)geofence
                        andLocation:(Location*)location;

- (BOOL)isValid;
@end
