//
//  Identifier.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Identifier.h"

@implementation Identifier

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
                      webUserFingerPrint:(NSString*)webUserFingerprint
              webAnalyticsCompanyZCookie:(NSString*)webAnalyticsCompanyZCookie
                              andUnknown:(NSString*)unknown
{
    self.datasnapUuid = datasnapUuid;
    self.domainSessionid = domainSessionId;
    self.facebookUuid = facebookUuid;
    self.global_Distinct_Id = globalDistinctId;
    self.globalUserIpAddress = globalUserIpAddress;
    self.hashedEmail = hashedEmail;
    self.mobileDeviceBluetoothIdentifier = mobileDeviceBluetoothIdentifier;
    self.mobileDeviceIosUdid = mobileDeviceIosUuid;
    self.mobileDeviceFingerprint = mobileDeviceFingerprint;
    self.mobileDeviceGoogleAdvertisingIdOptIn = mobileDeviceGoogleAdvertisingIdOptIn;
    self.webDomainUserid = webDomainUserId;
    self.webCookie = webCookie;
    self.webNetworkUserid = webNetworkUserId;
    self.webUserFingerprint = webUserFingerprint;
    self.webAnalyticsCompanyZCookie = webAnalyticsCompanyZCookie;
    self.unknown = unknown;

    if ([self.mobileDeviceGoogleAdvertisingIdOptIn boolValue] && !mobileDeviceIosIdfa) {
        self.mobileDeviceIosIdfa = [self identifierForAdvertising];
    }
    else {
        self.mobileDeviceIosIdfa = mobileDeviceIosIdfa;
    }

    return self;
}

- (NSString*)identifierForAdvertising
{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSUUID* IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        return [IDFA UUIDString];
    }
    return nil;
}

@end
