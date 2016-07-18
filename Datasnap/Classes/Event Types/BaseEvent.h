//
//  Event.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Device.h"
#import "NSObject+Helpers.h"
#import "User.h"

// Why are we importing this in the header file?
#import <Foundation/Foundation.h>

@class Datasnap;
@interface BaseEvent : NSObject
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
@property User* user;

/*
	Instead of checking if an event is valid, do not allow invalid events to be created.

	REMOVE:
	- (BOOL)isValid;
*/
- (NSDictionary*)convertToDictionary;
- (BaseEvent*)initWithEventType:(NSString*)eventType;
@end
