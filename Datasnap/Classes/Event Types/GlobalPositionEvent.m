//
//  GlobalPositionEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GlobalPositionEvent.h"

@implementation GlobalPositionEvent
- (GlobalPositionEvent*)globalPositionSighting:(NSArray*)coordinates
{
    self.globalPosition = [[GlobalPosition alloc] initWithCoordinates:coordinates];
    self.event_type = @"global_position_sighting";
    return self;
}

@end
