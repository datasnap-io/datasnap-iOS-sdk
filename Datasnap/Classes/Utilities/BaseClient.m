//
//  BaseClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseClient.h"
#import "Datasnap.h"

@implementation BaseClient
- (void)dsioBaseClient
{
    self.user = [self.user getInstance];
    self.deviceInfo = [self.deviceInfo getInstance];
    Datasnap* datasnap = [Datasnap sharedClient];
    self.organizationId = datasnap.organizationId;
    self.projectId = datasnap.projectId;
}
@end
