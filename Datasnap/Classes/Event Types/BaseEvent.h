//
//  Event.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DeviceInfo.h"
#import "User.h"
#import <Foundation/Foundation.h>
@class Datasnap;
@interface BaseEvent : NSObject
@property NSString* created;
@property NSString* dataSnapVersion;
@property NSString* eventType;
@property NSArray* organizationIds;
@property NSArray* projectIds;
@property NSString* customerOrgId;
@property NSString* customerVenueOrgId;
@property NSString* venueOrgId;
@property User* user;
@property DeviceInfo* deviceInfo;
@property NSDictionary* additionalProperties;
- (BOOL)validate;
- (NSDictionary*)convertToDictionary;
@end
