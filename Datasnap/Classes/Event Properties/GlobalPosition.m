//
//  GlobalPosition.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GlobalPosition.h"

@implementation GlobalPosition

- (GlobalPosition*)initWithLocation:(Location*)location
                           altitude:(NSString*)altitude
                           accuracy:(NSString*)accuracy
                             course:(NSString*)course
                         identifier:(NSString*)identifier
                           andSpeed:(NSString*)speed
{
    self.location = location;
    self.altitude = altitude;
    self.accuracy = accuracy;
    self.course = course;
    self.identifier = identifier;
    self.speed = speed;
    return self;
}
@end
