//
//  DSIOBaseClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIODeviceInfo.h"
#import "DSIOUser.h"
#import <Foundation/Foundation.h>
@class DSIODatasnap;
@interface DSIOBaseClient : NSObject
@property DSIOUser* user;
@property DSIODeviceInfo* deviceInfo;
@property NSString* organizationId;
@property NSString* projectId;
- (void)dsioBaseClient;
@end
