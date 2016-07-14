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
#import <Foundation/Foundation.h>

@class Datasnap;
@interface BaseEvent : NSObject
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* eventType;
@property NSArray* organizationIds;
@property NSArray* projectIds;
@property NSString* customerOrgId;
@property NSString* customerVenueOrgId;
@property NSString* venueOrgId;
@property User* user;
@property NSDictionary* additionalProperties;
- (BOOL)isValid;
- (NSDictionary*)convertToDictionary;
- (BaseEvent*)initWithEventType:(NSString*)eventType;
@end
