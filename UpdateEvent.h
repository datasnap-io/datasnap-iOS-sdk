//
//  UpdateEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "DSIOBeacon.h"
#import "DSIOPlace.h"
#import <Foundation/Foundation.h>

@interface UpdateEvent : BaseEvent
@property DSIOBeacon* beacon;
@property DSIOPlace* place;
@end
