//
//  Identifier.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import <AdSupport/ASIdentifierManager.h>

@interface Identifier : EventProperty
@property NSString* datasnapUuid;
@property NSString* domainSessionid;
@property NSString* facebookUuid;
@property NSString* globalDistinctId;
@property NSString* globalUserIpAddress;
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
- (Identifier *)initWithGlobalUserIpAddress:(NSString *)globalUserIpAddress
                                hashedEmail:(NSString *)hashedEmail
                         advertisingOptedIn:(BOOL)advertisingOptedIn;

@end
