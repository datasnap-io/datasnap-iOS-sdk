//
//  DSIOGeofenceCircle.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOEventProperty.h"
#import "DSIOLocation.h"

@interface DSIOGeofenceCircle : DSIOEventProperty
@property NSString* radius;
@property DSIOLocation* location;
- (NSDictionary*)convertToDictionary;
@end
