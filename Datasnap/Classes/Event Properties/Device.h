//
//  Device.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

@interface Device : EventProperty
@property NSString* ipAddress;
@property NSString* platform;
@property NSString* osVersion;
@property NSString* model;
@property NSString* manufacturer;
@property NSString* name;
@property NSString* vendorId;
@property NSString* carrierName;
@property NSString* countryCode;

- (Device*)init;

@end
