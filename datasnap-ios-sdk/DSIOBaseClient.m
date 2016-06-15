//
//  DSIOBaseClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOBaseClient.h"
#import "DataSnap.h"

@implementation DSIOBaseClient
- (void)dsioBaseClient
{
    self.user = [self.user getInstance];
    self.deviceInfo = [self.deviceInfo getInstance];
    DataSnap* datasnap = [DataSnap sharedClient];
    self.organizationId = datasnap.organizationId;
    self.projectId = datasnap.projectId;
}
@end
