//
//  BaseClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/14/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

@interface BaseClient : NSObject
@property NSString* organizationId;
@property NSString* projectId;
- (BaseClient*)initWithOrganizationId:(NSString*)organizationId
                            projectId:(NSString*)projectId;
@end
