//
//  DSIOPlace.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOPlace.h"

@implementation DSIOPlace
@synthesize id;
@synthesize name;
@synthesize address;
@synthesize lastPlace;
@synthesize beacons;
@synthesize geofences;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"id" : self.id ? self.id : [NSNull null],
        @"name" : self.name ? self.name : [NSNull null],
        @"address" : self.address ? self.address : [NSNull null],
        @"last_place" : self.lastPlace ? self.lastPlace : [NSNull null],
        @"beacons" : self.beacons ? self.beacons : [NSNull null],
        @"geofences" : self.geofences ? self.geofences : [NSNull null]
    };
    return dictionary;
}
@end
