//
//  GlobalPositionEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GlobalPositionEvent.h"

@implementation GlobalPositionEvent
@synthesize globalPosition;
- (GlobalPositionEvent*)initWithEventType:(NSString*)eventType
                        andGlobalPosition:(GlobalPosition*)globalPosition
{
    self.eventType = eventType;
    self.globalPosition = globalPosition;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
}
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"created" : self.created,
        @"dataSnap_Version" : self.dataSnapVersion,
        @"event_type" : self.eventType,
        @"organization_ids" : self.organizationIds,
        @"project_ids" : self.projectIds,
        @"customer_org_id" : self.customerOrgId ? self.customerOrgId : [NSNull null],
        @"customer_venue_org_id" : self.customerVenueOrgId ? self.customerVenueOrgId : [NSNull null],
        @"venue_org_id" : self.venueOrgId ? self.venueOrgId : [NSNull null],
        @"user" : [self.user convertToDictionary],
        @"device" : [self.device convertToDictionary],
        @"additional_properties" : self.additionalProperties ? self.additionalProperties : [NSNull null],
        @"global_position" : self.globalPosition ? [self.globalPosition convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
