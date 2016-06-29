//
//  BaseClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Device.h"
#import "User.h"
#import <Foundation/Foundation.h>

@interface BaseClient : NSObject
@property Device* device;
@property User* user;
@property NSString* organizationId;
@property NSString* projectId;
- (BaseClient*)initWithOrganizationId:(NSString*)organizationId
                            projectId:(NSString*)projectId
                               device:(Device*)device
                              andUser:(User*)user;
@end
