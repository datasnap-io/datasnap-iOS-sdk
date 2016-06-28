//
//  GlobalPositionEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "GlobalPosition.h"
#import <Foundation/Foundation.h>

@interface GlobalPositionEvent : BaseEvent
@property GlobalPosition* globalPosition;
@end
