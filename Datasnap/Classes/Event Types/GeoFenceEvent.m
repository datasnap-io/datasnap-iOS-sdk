//
//  GeoFenceEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "GeoFenceEvent.h"

@implementation GeoFenceEvent
@synthesize geofence;
@synthesize location;
- (GeoFenceEvent*)initWithEventType:(NSString*)eventType
                           geoFence:(Geofence*)geofence
                        andLocation:(Location*)location
{
    self.eventType = eventType;
    self.geofence = geofence;
    self.location = location;
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
        @"geofence" : self.geofence ? [self.geofence convertToDictionary] : [NSNull null],
        @"location" : self.location ? [self.location convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
- (BOOL)isValid
{
    return [super isValid] && self.geofence && self.location;
}
@end
