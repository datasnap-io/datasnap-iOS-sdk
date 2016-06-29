//
//  Identifier.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Identifier.h"

@implementation Identifier
@synthesize mobileDeviceBluetoothIdentifier;
@synthesize mobileDeviceIosIdfa;
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
@synthesize mobileDeviceGoogleAdvertisingIdOptIn;
@synthesize hashedEmail;
@synthesize unknown;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"datasnap_uuid" : self.datasnapUuid ? self.datasnapUuid : [NSNull null],
        @"domain_session_id" : self.domainSessionid ? self.domainSessionid : [NSNull null],
        @"facebook_uuid" : self.facebookUuid ? self.facebookUuid : [NSNull null],
        @"global_distinct_id" : self.globalDistinctId ? self.globalDistinctId : [NSNull null],
        @"global_user_id_address" : self.globalUserIpaddress ? self.globalUserIpaddress : [NSNull null],
        @"hashed_email" : self.hashedEmail ? self.hashedEmail : [NSNull null],
        @"mobile_device_bluetooth_identifier" : self.mobileDeviceBluetoothIdentifier ? self.mobileDeviceBluetoothIdentifier : [NSNull null],
        @"mobile_device_ios_idfa" : self.mobileDeviceIosIdfa ? self.mobileDeviceIosIdfa : [NSNull null],
        @"mobile_device_ios_udid" : self.mobileDeviceIosUdid ? self.mobileDeviceIosUdid : [NSNull null],
        @"mobile_device_google_advertising_id_opt_in" : self.mobileDeviceGoogleAdvertisingIdOptIn ? self.mobileDeviceGoogleAdvertisingIdOptIn : [NSNull null],
        @"web_domain_user_id" : self.webDomainUserid ? self.webDomainUserid : [NSNull null],
        @"web_cookie" : self.webCookie ? self.webCookie : [NSNull null],
        @"web_network_user_id" : self.webNetworkUserid ? self.domainSessionid : [NSNull null],
        @"web_user_fingerprint" : self.webUserFingerprint ? self.webUserFingerprint : [NSNull null],
        @"web_analytics_company_z_cookie" : self.webAnalyticsCompanyZCookie ? self.webAnalyticsCompanyZCookie : [NSNull null],
        @"unknown" : self.unknown ? self.unknown : [NSNull null]
    };
    return dictionary;
}
- (Identifier*)initWithDatasnapUuid:(NSString*)datasnapUuid
                         domainSessionId:(NSString*)domainSessionId
                            facebookUuid:(NSString*)facebookUuid
                        globalDistinctId:(NSString*)globalDistinctId
                     globalUserIpAddress:(NSString*)globalUserIpAddress
                             hashedEmail:(NSString*)hashedEmail
         mobileDeviceBluetoothIdentifier:(NSString*)mobileDeviceBluetoothIdentifier
                     mobileDeviceIosIdfa:(NSString*)mobileDeviceIosIdfa
                     mobileDeviceIosUdid:(NSString*)mobileDeviceIosUuid
                 mobileDeviceFingerprint:(NSString*)mobileDeviceFingerprint
    mobileDeviceGoogleAdvertisingIdOptIn:(NSString*)mobileDeviceGoogleAdvertisingIdOptIn
                         webDomainUserId:(NSString*)webDomainUserId
                               webCookie:(NSString*)webCookie
                        webNetworkUserId:(NSString*)webNetworkUserId
                      webUserFingerPrint:(NSString*)webUserFingerPrint
              webAnalyticsCompanyZCookie:(NSString*)webAnalyticsCompanyZCookie
                              andUnknown:(NSString*)unknown
{
    self.datasnapUuid = datasnapUuid;
    self.domainSessionid = domainSessionId;
    self.facebookUuid = facebookUuid;
    self.globalDistinctId = globalDistinctId;
    self.globalUserIpaddress = globalUserIpaddress;
    self.hashedEmail = hashedEmail;
    self.mobileDeviceBluetoothIdentifier = mobileDeviceBluetoothIdentifier;
    self.mobileDeviceIosIdfa = mobileDeviceIosIdfa;
    self.mobileDeviceIosUdid = mobileDeviceIosUdid;
    self.mobileDeviceFingerprint = mobileDeviceFingerprint;
    self.mobileDeviceGoogleAdvertisingIdOptIn = mobileDeviceGoogleAdvertisingIdOptIn;
    self.webDomainUserid = webDomainUserid;
    self.webCookie = webCookie;
    self.webNetworkUserid = webNetworkUserid;
    self.webUserFingerprint = webUserFingerprint;
    self.webAnalyticsCompanyZCookie = webAnalyticsCompanyZCookie;
    self.unknown = unknown;
    return self;
}
@end
