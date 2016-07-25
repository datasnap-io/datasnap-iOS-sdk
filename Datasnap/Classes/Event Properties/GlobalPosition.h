//
//  GlobalPosition.h
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//
#import "EventProperty.h"
#import "Location.h"

@interface GlobalPosition : EventProperty
@property Location* location;
- (GlobalPosition*)initWithCoordinates:(NSArray*)coordinates;
@end
