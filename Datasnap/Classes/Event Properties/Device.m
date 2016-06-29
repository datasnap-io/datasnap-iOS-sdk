//
//  Device.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Device.h"

@implementation Device
@synthesize ipAddress;
@synthesize platform;
@synthesize osVersion;
@synthesize model;
@synthesize manufacturer;
@synthesize name;
@synthesize vendorId;
@synthesize carrierName;
@synthesize countryCode;

- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"carrier_name" : self.carrierName ? self.carrierName : [NSNull null],
        @"country_code" : self.countryCode,
        @"ip_address" : self.ipAddress,
        @"platform" : self.platform,
        @"os_version" : self.osVersion,
        @"model" : self.model,
        @"manufacturer" : self.manufacturer,
        @"name" : self.name,
        @"vendor_id" : self.vendorId
    };
    return dictionary;
}
- (Device*)init
{
    self.manufacturer = @"Apple";
    self.model = [UIDevice currentDevice].model;
    self.platform = [UIDevice currentDevice].systemName;
    self.osVersion = [UIDevice currentDevice].systemVersion;
    self.name = [UIDevice currentDevice].name;
    self.vendorId = [NSString stringWithFormat:@"%@", [UIDevice currentDevice].identifierForVendor];
    self.carrierName = [self getCarrierName];
    self.ipAddress = [self getIPAddress];
    self.countryCode = [self getCountyCode];
    return self;
}
- (NSString*)getCarrierName
{
    CTTelephonyNetworkInfo* netinfo = [CTTelephonyNetworkInfo new];
    CTCarrier* carrier = [netinfo subscriberCellularProvider];
    return [carrier carrierName];
}
- (NSString*)getIPAddress
{
    NSString* address = @"error";
    struct ifaddrs* interfaces = NULL;
    struct ifaddrs* temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in*)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}
- (NSString*)getCountyCode
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    return countryCode;
}

@end
