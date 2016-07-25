//
//  GlobalPositionEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "GlobalPosition.h"
@interface GlobalPositionEvent : BaseEvent
@property NSArray* coordinates;
@property GlobalPosition* globalPosition;
- (GlobalPositionEvent*)globalPositionSighting:(NSArray*)coordinates;
@end
