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
@property NSString* event_type;
@property NSArray* organization_ids;
@property NSArray* project_ids;
@property User* user;
- (UpdateEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
                         andPlace:(Place*)place;

- (BOOL)isValid;
@end
