//
//  GlobalPositionEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "GlobalPosition.h"

// Why are we importing this in the header file?
#import <Foundation/Foundation.h>

@interface GlobalPositionEvent : BaseEvent
@property GlobalPosition* globalPosition;
- (GlobalPositionEvent*)globalPositionSighting:(NSArray*)coordinates;
@end
