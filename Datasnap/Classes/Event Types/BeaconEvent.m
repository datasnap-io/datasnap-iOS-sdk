//
//  BeaconEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BeaconEvent.h"

@implementation BeaconEvent
@synthesize place;
@synthesize beacon;
- (BeaconEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
{
    self.eventType = eventType;
    self.beacon = beacon;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}
@end
