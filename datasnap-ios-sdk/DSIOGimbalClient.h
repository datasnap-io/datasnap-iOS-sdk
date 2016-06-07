//
//  DSIOGimbalClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Campaign.h"
#import "Communication.h"
#import "DSIOAPI.h"
#import "DSIOClient.h"
#import "DSIOEventQueue.h"
#import <Gimbal/Gimbal.h>

@interface DSIOGimbalClient : DSIOClient <GMBLBeaconManagerDelegate>
@property DSIOClient* client;
@property NSDictionary* sighting;
@property NSString* global_distinct_id;
@property NSString* mobile_device_ios_idfa;
@property (nonatomic, strong) DSIOAPI* api;
+ (void)setupWithOrgID:(NSString*)organizationID
             projectId:(NSString*)projectID
                APIKey:(NSString*)APIKey
             APISecret:(NSString*)APISecret
               logging:(BOOL)logging
              eventNum:(int)eventNum
                    id:(NSString*)global_distinct_id
              mobileId:(NSString*)mobile_device_ios_idfa;
+ (id)sharedClient;
@end
