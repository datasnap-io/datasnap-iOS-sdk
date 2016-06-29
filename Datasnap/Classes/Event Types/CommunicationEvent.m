//
//  CommunicationEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "CommunicationEvent.h"

@implementation CommunicationEvent
@synthesize communication;
@synthesize campaign;
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
- (BOOL)validate
{
    return self.organizationIds.count > 0 && self.projectIds.count > 0 && self.user && self.device && self.communication && self.campaign;
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
        @"datasnap" : @{ @"device" : [self.device convertToDictionary],
            @"created" : self.created },
        @"additional_properties" : self.additionalProperties ? self.additionalProperties : [NSNull null],
        @"communication" : self.communication ? [self.communication convertToDictionary] : [NSNull null],
        @"campaign" : self.campaign ? [self.campaign convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
