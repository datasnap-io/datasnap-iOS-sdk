//
//  DSIOBeacon.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOEventProperty.h"
#import "DSIOTags.h"
#import <Gimbal/Gimbal.h>
#import <objc/runtime.h>

@interface DSIOBeacon : DSIOEventProperty
@property NSString* identifier;
@property NSString* uuid;
@property NSString* name;
@property NSString* batteryLevel;
@property NSString* temperature;
@property NSString* bleVendorUuid;
@property NSString* bleVendorId;
@property NSString* rssi;
@property NSString* isMobile;
@property NSString* previousRssi;
@property NSString* dwellTime;
@property NSString* startTime;
@property NSString* lastUpdateTime;
@property NSString* latitude;
@property NSString* longitude;
@property NSString* visibility;
@property NSString* hardware;
@property DSIOTags* tags;
- (NSDictionary*)convertToDictionary;
@end
