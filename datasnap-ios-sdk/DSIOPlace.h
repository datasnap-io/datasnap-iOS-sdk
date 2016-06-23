//
//  DSIOPlace.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEventProperty.h"

@interface DSIOPlace : DSIOEventProperty
@property NSString* id;
@property NSString* name;
@property NSString* address;
@property NSString* lastPlace;
@property NSArray* beacons;
@property NSArray* geofences;
- (NSDictionary*)convertToDictionary;
@end
