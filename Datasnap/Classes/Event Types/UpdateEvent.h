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
- (UpdateEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
                         andPlace:(Place*)place;
- (NSDictionary*)convertToDictionary;
- (BOOL)isValid;
@end
