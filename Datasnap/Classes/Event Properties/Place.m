//
//  Place.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Place.h"

@implementation Place

- (Place*)initWithName:(NSString*)name
               address:(NSString*)address
             lastPlace:(NSString*)lastPlace
          andGeofences:(NSArray*)geoFences
{
    self.name = name;
    self.address = address;
    self.lastPlace = lastPlace;
    self.geofences = geoFences;
    return self;
}
@end
