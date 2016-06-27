//
//  DeviceInfo.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo
@synthesize created;
@synthesize device;
- (void)initializeDeviceInfo:(DeviceInfo*)deviceInfo
{
    self.deviceInfo = deviceInfo;
}
- (DeviceInfo*)getInstance
{
    return self.deviceInfo;
}
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"created" : self.created ? self.created : [NSNull null],
        @"device" : [self.device convertToDictionary]
    };
    return dictionary;
}
@end
