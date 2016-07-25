//
//  Location.h
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//

#import "EventProperty.h"

@interface Location : EventProperty
@property NSArray* coordinates;
- (Location*)initWithCoordinates:(NSArray*)coordinates;
@end
