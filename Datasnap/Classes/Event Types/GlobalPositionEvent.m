//
//  GlobalPositionEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GlobalPositionEvent.h"

@implementation GlobalPositionEvent
- (GlobalPositionEvent*)initWithEventType:(NSString*)eventType
                        andGlobalPosition:(GlobalPosition*)globalPosition
{
    self.event_type = eventType;
    self.globalPosition = globalPosition;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}

- (BOOL)isValid
{
    return [super isValid] && self.globalPosition;
}
@end
