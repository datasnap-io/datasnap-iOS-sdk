//
//  Event.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Device.h"
#import "EventProperty.h"
#import "Identifier.h"
#import "NSObject+Helpers.h"
#import "User.h"

@class Datasnap;
@interface BaseEvent : NSObject
@property EventProperty* eventProperty;
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
@property User* user;
- (NSDictionary*)convertToDictionary;
- (BaseEvent*)initWithEventType:(NSString*)eventType;
+ (NSDictionary*)classPropsForClassHierarchy:(Class) class;
- (NSDictionary*)dictionary;
@end
