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
@property NSString* eventType;
@property NSArray* organization_Ids;
@property NSArray* project_Ids;
@property NSString* customerOrgId;
@property NSString* customerVenueOrgId;
@property NSString* venueOrgId;
@property User* user;
@property NSDictionary* additionalProperties;
- (GlobalPositionEvent*)initWithEventType:(NSString*)eventType
                        andGlobalPosition:(GlobalPosition*)globalPosition;

- (BOOL)isValid;
@end
