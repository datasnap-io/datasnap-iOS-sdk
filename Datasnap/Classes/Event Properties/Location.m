//
//  Location.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Location.h"

@implementation Location

- (Location*)initWithCoordinates:(NSArray*)coordinates
{
    self.coordinates = coordinates;
    return self;
}
@end
