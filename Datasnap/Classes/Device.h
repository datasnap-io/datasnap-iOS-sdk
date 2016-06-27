//
//  Device.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface Device : EventProperty
@property NSString* userAgent;
@property NSString* ipAddress;
@property NSString* platform;
@property NSString* osVersion;
@property NSString* model;
@property NSString* manufacturer;
@property NSString* name;
@property NSString* vendorId;
@property NSString* carrierName;
@property NSString* countryCode;
@property NSString* networkCode;
- (NSDictionary*)convertToDictionary;
@end
