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
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
@property User* user;
- (GlobalPositionEvent*)initWithEventType:(NSString*)eventType
                        andGlobalPosition:(GlobalPosition*)globalPosition;

- (BOOL)isValid;
@end
