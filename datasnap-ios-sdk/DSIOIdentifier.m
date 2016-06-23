//
//  DSIOIdentifier.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOIdentifier.h"

@implementation DSIOIdentifier
@synthesize mobileDeviceBluetoothIdentifier;
@synthesize mobileDeviceIosIdfa;
@synthesize mobileDeviceIosOpenidfa;
@synthesize mobileDeviceIosUdid;
@synthesize datasnapUuid;
@synthesize webDomainUserid;
@synthesize webCookie;
@synthesize domainSessionid;
@synthesize webNetworkUserid;
@synthesize webUserFingerprint;
@synthesize webAnalyticsCompanyZCookie;
@synthesize globalDistinctId;
@synthesize globalUserIpaddress;
@synthesize mobileDeviceFingerprint;
@synthesize facebookUuid;
@synthesize mobileDeviceGoogleAdvertisingId;
@synthesize mobileDeviceGoogleAdvertisingIdOptIn;
@synthesize unknown;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"mobile_device_bluetooth_identifier" : self.mobileDeviceBluetoothIdentifier ? self.mobileDeviceBluetoothIdentifier : [NSNull null],
        @"mobile_device_ios_idfa" : self.mobileDeviceIosIdfa ? self.mobileDeviceIosIdfa : [NSNull null],
        @"mobile_device_ios_open_idfa" : self.mobileDeviceIosOpenidfa ? self.mobileDeviceIosOpenidfa : [NSNull null],
        @"mobile_device_ios_udid" : self.mobileDeviceIosUdid ? self.mobileDeviceIosUdid : [NSNull null],
        @"datasnap_uuid" : self.datasnapUuid ? self.datasnapUuid : [NSNull null],
        @"web_domain_user_id" : self.webDomainUserid ? self.webDomainUserid : [NSNull null],
        @"web_cookie" : self.webCookie ? self.webCookie : [NSNull null],
        @"domain_session_id" : self.domainSessionid ? self.domainSessionid : [NSNull null],
        @"web_network_user_id" : self.webNetworkUserid ? self.domainSessionid : [NSNull null],
        @"web_user_fingerprint" : self.webUserFingerprint ? self.webUserFingerprint : [NSNull null],
        @"web_analytics_company_z_cookie" : self.webAnalyticsCompanyZCookie ? self.webAnalyticsCompanyZCookie : [NSNull null],
        @"global_distinct_id" : self.globalDistinctId ? self.globalDistinctId : [NSNull null],
        @"global_user_id_address" : self.globalUserIpaddress ? self.globalUserIpaddress : [NSNull null],
        @"mobile_device_google_advertising_id" : self.mobileDeviceGoogleAdvertisingId ? self.mobileDeviceGoogleAdvertisingId : [NSNull null],
        @"mobile_device_google_advertising_id_opt_in" : self.mobileDeviceGoogleAdvertisingIdOptIn ? self.mobileDeviceGoogleAdvertisingIdOptIn : [NSNull null],
        @"unknown" : self.unknown ? self.unknown : [NSNull null],
        @"facebook_uuid" : self.facebookUuid ? self.facebookUuid : [NSNull null]
    };
    return dictionary;
}
@end
