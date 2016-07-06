//
//  Place.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Place.h"

@implementation Place
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"id" : self.identifier ? self.identifier : [NSNull null],
        @"name" : self.name ? self.name : [NSNull null],
        @"address" : self.address ? self.address : [NSNull null],
        @"last_place" : self.lastPlace ? self.lastPlace : [NSNull null],
        @"geofences" : self.geofences ? self.geofences : [NSNull null]
    };
    return dictionary;
}
- (Place*)initWithName:(NSString*)name
               address:(NSString*)address
             lastPlace:(NSString*)lastPlace
          andGeofences:(NSArray*)geoFences
{
    self.name = name;
    self.address = address;
    self.lastPlace = lastPlace;
    self.geofences = geoFences;
    return self;
}
@end
