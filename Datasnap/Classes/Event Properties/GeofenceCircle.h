//
//  GeofenceCircle.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "Location.h"

@interface GeofenceCircle : EventProperty
@property NSString* radius;
@property Location* location;
- (NSDictionary*)convertToDictionary;
@end
