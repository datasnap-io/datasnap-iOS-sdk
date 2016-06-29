//
//  Identifier.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"

@interface Identifier : EventProperty
@property NSString* datasnapUuid;
@property NSString* domainSessionid;
@property NSString* facebookUuid;
@property NSString* globalDistinctId;
@property NSString* globalUserIpaddress;
@property NSString* hashedEmail;
@property NSString* mobileDeviceBluetoothIdentifier;
@property NSString* mobileDeviceIosIdfa;
@property NSString* mobileDeviceIosUdid;
@property NSString* mobileDeviceFingerprint;
@property NSString* mobileDeviceGoogleAdvertisingIdOptIn;
@property NSString* webDomainUserid;
@property NSString* webCookie;
@property NSString* webNetworkUserid;
@property NSString* webUserFingerprint;
@property NSString* webAnalyticsCompanyZCookie;
@property NSString* unknown;
- (NSDictionary*)convertToDictionary;
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
                              andUnknown:(NSString*)unknown;
@end
