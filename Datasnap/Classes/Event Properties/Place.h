//
//  Place.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface Place : EventProperty
@property NSString* name;
@property NSString* address;
@property NSString* lastPlace;
@property NSArray* beacons;
@property NSArray* geofences;
- (NSDictionary*)convertToDictionary;
@end
