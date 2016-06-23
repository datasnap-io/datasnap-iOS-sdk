//
//  DSIOGeofenceCircle.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOGeofenceCircle.h"

@implementation DSIOGeofenceCircle
@synthesize radius;
@synthesize location;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"radius" : self.radius ? self.radius : [NSNull null],
        @"location" : [self.location convertToDictionary] ? [self.location convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
