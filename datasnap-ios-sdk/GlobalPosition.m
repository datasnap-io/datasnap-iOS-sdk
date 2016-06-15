//
//  GlobalPosition.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GlobalPosition.h"

@implementation GlobalPosition
@synthesize location;
@synthesize altitude;
@synthesize accuracy;
@synthesize course;
@synthesize speed;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"location" : [self.location convertToDictionary] ? [self.location convertToDictionary] : [NSNull null],
        @"altitude" : self.altitude ? self.altitude : [NSNull null],
        @"accuracy" : self.accuracy ? self.accuracy : [NSNull null],
        @"course" : self.course ? self.course : [NSNull null],
        @"speed" : self.speed ? self.speed : [NSNull null]
    };
    return dictionary;
}
@end
