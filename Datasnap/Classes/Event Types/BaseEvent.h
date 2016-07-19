//
//  Event.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Device.h"
#import "NSObject+Helpers.h"

@class Datasnap;
@interface BaseEvent : NSObject
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
- (NSDictionary*)convertToDictionary;
- (BaseEvent*)initWithEventType:(NSString*)eventType;
+ (NSDictionary*)classPropsForClassHierarchy:(Class) class;
- (NSDictionary*)dictionary;
@end
