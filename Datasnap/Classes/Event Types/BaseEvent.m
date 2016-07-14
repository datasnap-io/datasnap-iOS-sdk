//
//  Event.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"

@implementation BaseEvent
- (BOOL)isValid
{
    return self.organization_Ids.count > 0 && self.project_Ids.count > 0 && self.user && self.device;
}
- (NSDictionary*)convertToDictionary
{
    return [self dictionary];
}
- (BaseEvent*)initWithEventType:(NSString*)eventType
{
    self.eventType = eventType;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}
@end
