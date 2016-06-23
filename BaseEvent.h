//
//  Event.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIODeviceInfo.h"
#import "DSIOUser.h"
#import <Foundation/Foundation.h>
@class DSIODatasnap;
@interface BaseEvent : NSObject
@property NSString* created;
@property NSString* dataSnapVersion;
@property NSString* eventType;
@property NSMutableArray* organizationIds;
@property NSMutableArray* projectIds;
@property NSString* customerOrgId;
@property NSString* customerVenueOrgId;
@property NSString* venueOrgId;
@property DSIOUser* user;
@property DSIODeviceInfo* deviceInfo;
@property NSDictionary* additionalProperties;
- (BOOL)validate;
- (NSDictionary*)convertToDictionary;
@end
