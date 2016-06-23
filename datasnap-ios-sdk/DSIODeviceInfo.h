//
//  DSIODeviceInfo.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIODevice.h"
#import "DSIOEventProperty.h"

@interface DSIODeviceInfo : DSIOEventProperty
@property NSString* created;
@property DSIODevice* device;
@property (nonatomic, strong) DSIODeviceInfo* deviceInfo;
- (DSIODeviceInfo*)getInstance;
- (void)initializeDeviceInfo:(DSIODeviceInfo*)deviceInfo;
- (NSDictionary*)convertToDictionary;
@end
