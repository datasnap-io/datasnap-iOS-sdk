//
//  DeviceInfo.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Device.h"
#import "EventProperty.h"

@interface DeviceInfo : EventProperty
@property NSString* created;
@property Device* device;
@property (nonatomic, strong) DeviceInfo* deviceInfo;
- (DeviceInfo*)getInstance;
- (void)initializeDeviceInfo:(DeviceInfo*)deviceInfo;
- (NSDictionary*)convertToDictionary;
@end
