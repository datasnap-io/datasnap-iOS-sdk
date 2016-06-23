//
//  GeoFence.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOEventProperty.h"
#import "DSIOGeofenceCircle.h"
#import "DSIOTags.h"

@interface DSIOGeofence : DSIOEventProperty
@property NSString* identifier;
@property NSString* name;
@property NSString* visibility;
@property DSIOTags* tags;
@property DSIOGeofenceCircle* geofenceCircle;
- (NSDictionary*)convertToDictionary;
@end
