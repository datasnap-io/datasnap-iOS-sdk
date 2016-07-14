//
//  CommunicationEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "CommunicationEvent.h"

@implementation CommunicationEvent
- (CommunicationEvent*)initWithEventType:(NSString*)eventType
                           communication:(Communication*)communication
                                campaign:(Campaign*)campaign
                              venueOrgId:(NSString*)venueOrgId
                           customerOrgId:(NSString*)customerOrgId
{
    self.eventType = eventType;
    self.communication = communication;
    self.campaign = campaign;
    self.venueOrgId = venueOrgId;
    self.customerOrgId = customerOrgId;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}
- (BOOL)isValid
{
    return [super isValid] && self.communication && self.campaign;
}

@end
