//
//  DSIOGimbalClient.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOGimbalClient.h"
static DSIOClient* sharedInstance = nil;
@implementation DSIOGimbalClient
- (void)beaconManager:(GMBLBeaconManager*)manager didReceiveBeaconSighting:(GMBLBeaconSighting*)sighting
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSDictionary* beaconData = @{ @"event_type" : @"beacon_sighting",
        @"beacon" : @{ @"identifier" : sighting.beacon.identifier,
            @"rssi" : [NSString stringWithFormat:@"%ld", (long)sighting.RSSI] },
        @"datasnap" : @{ @"created" : [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:sighting.date]] },
        @"user" : @{
            @"id" : @{
                @"global_distinct_id" : self.global_distinct_id,
                @"mobile_device_ios_idfa" : self.mobile_device_ios_idfa
            }
        }
    };
    NSLog(@"Beacon sighting");
    NSLog(@"%@", sighting.beacon.identifier);
    [[DSIOClient sharedClient] genericEvent:[beaconData mutableCopy]];
}
+ (void)setupWithOrgID:(NSString*)organizationID
             projectId:(NSString*)projectID
                APIKey:(NSString*)APIKey
             APISecret:(NSString*)APISecret
               logging:(BOOL)logging
              eventNum:(int)eventNum
                    id:(NSString*)global_distinct_id
              mobileId:(NSString*)mobile_device_ios_idfa
{
    [self debug:logging];
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithOrgID:organizationID projectId:(NSString*)projectID APIKey:APIKey APISecret:APISecret eventNum:eventNum id:global_distinct_id mobileId:mobile_device_ios_idfa];
    });
    [DSIOClient setupWithOrgID:organizationID projectId:projectID APIKey:APIKey APISecret:APISecret logging:logging eventNum:eventNum];
}
- (id)initWithOrgID:(NSString*)organizationID projectId:(NSString*)projectID APIKey:(NSString*)APIKey APISecret:(NSString*)APISecret eventNum:(int)eventNum id:(NSString*)global_distinct_id mobileId:(NSString*)mobile_device_ios_idfa
{
    if (self = [self init]) {
        self.client.organizationID = organizationID;
        self.client.projectID = projectID;
        self.global_distinct_id = global_distinct_id;
        self.mobile_device_ios_idfa = mobile_device_ios_idfa;
        self.client.eventQueue = [[DSIOEventQueue alloc] initWithSize:eventNum];
        self.api = [[DSIOAPI alloc] initWithKey:APIKey secret:APISecret];
    }
    return self;
}
+ (id)sharedClient
{
    return sharedInstance;
}
@end
