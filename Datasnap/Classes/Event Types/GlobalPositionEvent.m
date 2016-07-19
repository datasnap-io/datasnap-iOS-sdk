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
    self.coordinates = coordinates;
    return self;
}

@end
