//
//  Event.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"

@implementation BaseEvent
@synthesize dataSnapVersion;
@synthesize eventType;
@synthesize organizationIds;
@synthesize projectIds;
@synthesize customerOrgId;
@synthesize customerVenueOrgId;
@synthesize venueOrgId;
@synthesize user;
@synthesize device;
@synthesize additionalProperties;
@synthesize created;
- (BOOL)isValid
{
    return self.organizationIds.count > 0 && self.projectIds.count > 0 && self.user && self.device;
}
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"dataSnap_Version" : self.dataSnapVersion,
        @"event_type" : self.eventType,
        @"organization_ids" : self.organizationIds,
        @"project_ids" : self.projectIds,
        @"customer_org_id" : self.customerOrgId ? self.customerOrgId : [NSNull null],
        @"customer_venue_org_id" : self.customerVenueOrgId ? self.customerVenueOrgId : [NSNull null],
        @"venue_org_id" : self.venueOrgId ? self.venueOrgId : [NSNull null],
        @"user" : [self.user convertToDictionary],
        @"datasnap": @{@"device" : [self.device convertToDictionary],
                        @"created" : self.created},
        @"additional_properties" : self.additionalProperties ? self.additionalProperties : [NSNull null]
    };
    return dictionary;
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
