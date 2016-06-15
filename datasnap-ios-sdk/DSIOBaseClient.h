//
//  DSIOBaseClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DeviceInfo.h"
#import "User.h"
#import <Foundation/Foundation.h>
@class DataSnap;
@interface DSIOBaseClient : NSObject
@property User* user;
@property DeviceInfo* deviceInfo;
@property NSString* organizationId;
@property NSString* projectId;
- (void)dsioBaseClient;
@end
