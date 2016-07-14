//
//  UpdateEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Beacon.h"
#import "Place.h"
#import <Foundation/Foundation.h>

@interface UpdateEvent : BaseEvent
@property Beacon* beacon;
@property Place* place;
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
- (UpdateEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
                         andPlace:(Place*)place;

- (BOOL)isValid;
@end
