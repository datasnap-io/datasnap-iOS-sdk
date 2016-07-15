//
//  GeoFenceEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GeoFenceEvent.h"

@implementation GeoFenceEvent

- (GeoFenceEvent*)initWithEventType:(NSString*)eventType
                           geoFence:(Geofence*)geofence
                        andLocation:(Location*)location
{
    self.event_type = eventType;
    self.geofence = geofence;
    self.location = location;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}

- (BOOL)isValid
{
    return [super isValid] && self.geofence && self.location;
}
@end
