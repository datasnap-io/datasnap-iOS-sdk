//
//  Device.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Device.h"

@implementation Device
@synthesize userAgent;
@synthesize ipAddress;
@synthesize platform;
@synthesize osVersion;
@synthesize model;
@synthesize manufacturer;
@synthesize name;
@synthesize vendorId;
@synthesize carrierName;
@synthesize countryCode;
@synthesize networkCode;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"user_agent" : self.userAgent ? self.userAgent : [NSNull null],
        @"ip_address" : self.ipAddress,
        @"platform" : self.platform,
        @"os_version" : self.osVersion,
        @"model" : self.model,
        @"manufacturer" : self.manufacturer,
        @"name" : self.name,
        @"vendor_id" : self.vendorId,
        @"carrier_name" : self.carrierName ? self.carrierName : [NSNull null],
        @"country_code" : self.countryCode,
        @"network_code" : self.networkCode ? self.networkCode : [NSNull null]
    };
    return dictionary;
}
@end
