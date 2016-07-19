//
//  BaseClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseClient.h"

@implementation BaseClient
- (BaseClient*)initWithOrganizationId:(NSString*)organizationId
                            projectId:(NSString*)projectId
                               device:(Device*)device
{
    self.organizationId = organizationId;
    self.projectId = projectId;
    self.device = device;
    return self;
}
@end
