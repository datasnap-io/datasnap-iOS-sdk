//
//  Event.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Datasnap.h"

@implementation BaseEvent
@synthesize dataSnapVersion;
@synthesize eventType;
@synthesize organizationIds;
@synthesize projectIds;
@synthesize customerOrgId;
@synthesize customerVenueOrgId;
@synthesize venueOrgId;
@synthesize user;
@synthesize deviceInfo;
@synthesize additionalProperties;
@synthesize created;
- (BOOL)validate
{
    return self.organizationIds.count > 0 && [self.organizationIds[0] length] > 0 && self.projectIds.count > 0 && [self.projectIds[0] length] > 0 && self.user;
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
        @"device_info" : [self.deviceInfo convertToDictionary],
        @"additional_properties" : self.additionalProperties ? self.additionalProperties : [NSNull null]
    };
    return dictionary;
}
@end
