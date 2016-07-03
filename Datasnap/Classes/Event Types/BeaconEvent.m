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
- (BOOL)isValid
{
    return [super isValid];
}
- (BeaconEvent*)initWithEventType:(NSString*)eventType
                           beacon:(Beacon*)beacon
                         andPlace:(Place*)place
{
    self.eventType = eventType;
    self.beacon = beacon;
    self.place = place;
    self.dataSnapVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    self.created = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    return self;
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
        @"place" : self.place ? [self.place convertToDictionary] : [NSNull null],
        @"beacon" : self.beacon ? [self.beacon convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
