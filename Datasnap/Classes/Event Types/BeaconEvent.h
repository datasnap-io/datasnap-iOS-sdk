//
//  BeaconEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Beacon.h"
#import "EventEntity.h"
#import "Place.h"
#import "User.h"
#import <Foundation/Foundation.h>

@interface BeaconEvent : BaseEvent
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
@property User* user;
@property Place* place;
@property Beacon* beacon;
- (BOOL)isValid;
- (BeaconEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
                         andPlace:(Place*)place;
@end
