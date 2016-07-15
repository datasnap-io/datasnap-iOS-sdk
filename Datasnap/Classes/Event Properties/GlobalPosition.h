//
//  GlobalPosition.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "Location.h"

@interface GlobalPosition : EventProperty
@property Location* location;
@property NSString* altitude;
@property NSString* identifier;
- (GlobalPosition*)initWithLocation:(Location*)location
                           altitude:(NSString*)altitude
                         identifier:(NSString*)identifier;
@end
