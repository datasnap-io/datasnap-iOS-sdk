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
                         identifier:(NSString*)identifier
{
    self.location = location;
    self.altitude = altitude;
    self.identifier = identifier;
    return self;
}
@end
