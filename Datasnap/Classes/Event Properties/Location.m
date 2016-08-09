//
//  Location.m
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//

#import "Location.h"

@implementation Location
- (Location*)initWithCoordinates:(NSArray*)coordinates
{
    self.coordinates = coordinates;
    return self;
}
@end
