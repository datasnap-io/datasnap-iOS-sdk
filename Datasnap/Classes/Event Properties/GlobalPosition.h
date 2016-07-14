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
@property NSString* accuracy;
@property NSString* course;
@property NSString* speed;
@property NSString* identifier;
- (GlobalPosition*)initWithLocation:(Location*)location
                           altitude:(NSString*)altitude
                           accuracy:(NSString*)accuracy
                             course:(NSString*)course
                         identifier:(NSString*)identifier
                           andSpeed:(NSString*)speed;
@end
