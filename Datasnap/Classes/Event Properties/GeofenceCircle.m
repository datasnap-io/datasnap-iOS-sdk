//
//  GeofenceCircle.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GeofenceCircle.h"

@implementation GeofenceCircle
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"radius" : self.radius ? self.radius : [NSNull null],
        @"location" : [self.location convertToDictionary] ? [self.location convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
- (GeofenceCircle*)initWithRadius:(NSString*)radius
                      andLocation:(Location*)location
{
    self.radius = radius;
    self.location = location;
    return self;
}
@end
