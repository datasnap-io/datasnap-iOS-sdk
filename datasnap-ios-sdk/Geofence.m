//
//  GeoFence.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GeoFence.h"

@implementation Geofence
@synthesize identifier;
@synthesize name;
@synthesize visibility;
@synthesize tags;
@synthesize geofenceCircle;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"id" : self.identifier ? self.identifier : [NSNull null],
        @"name" : self.name ? self.name : [NSNull null],
        @"visibility" : self.visibility ? self.visibility : [NSNull null],
        @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null],
        @"geofence_circle" : [self.geofenceCircle convertToDictionary] ? [self.geofenceCircle convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
