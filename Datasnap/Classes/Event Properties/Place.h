//
//  Place.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface Place : EventProperty
@property NSString* name;
@property NSString* address;
@property NSArray* geofences;

- (Place*)initWithName:(NSString*)name
               address:(NSString*)address
          andGeofences:(NSArray*)geoFences;
@end
