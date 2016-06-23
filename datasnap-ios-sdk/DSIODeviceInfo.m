//
//  DSIODeviceInfo.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIODeviceInfo.h"

@implementation DSIODeviceInfo
@synthesize created;
@synthesize device;
- (void)initializeDeviceInfo:(DSIODeviceInfo*)deviceInfo
{
    self.deviceInfo = deviceInfo;
}
- (DSIODeviceInfo*)getInstance
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
