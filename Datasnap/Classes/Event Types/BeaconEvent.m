//
//  BeaconEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BeaconEvent.h"

@implementation BeaconEvent
- (BOOL)isValid
{
    return [super isValid] && self.beacon;
}
- (BeaconEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
                         andPlace:(Place*)place
{
    self.event_type = eventType;
    self.beacon = beacon;
    self.place = place;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}

@end
