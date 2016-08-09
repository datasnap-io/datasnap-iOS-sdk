//
//  GlobalPosition.m
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//

#import "GlobalPosition.h"

@implementation GlobalPosition
- (GlobalPosition*)initWithCoordinates:(NSArray*)coordinates
{
    self.location = [[Location alloc] initWithCoordinates:coordinates];
    return self;
}
@end
