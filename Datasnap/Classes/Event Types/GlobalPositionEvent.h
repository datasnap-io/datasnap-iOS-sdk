//
//  GlobalPositionEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"

@interface GlobalPositionEvent : BaseEvent
@property NSArray* coordinates;
- (GlobalPositionEvent*)globalPositionSighting:(NSArray*)coordinates;
@end
