//
//  DSIOGimbalClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BeaconEvent.h"
#import "DSIOCampaign.h"
#import "DSIOCommunication.h"
#import "CommunicationEvent.h"
#import "DSIOAPI.h"
#import "DSIOBaseClient.h"
#import "DSIOEventQueue.h"
#import <Gimbal/Gimbal.h>

@interface DSIOGimbalClient : DSIOBaseClient <GMBLBeaconManagerDelegate, GMBLCommunicationManagerDelegate, GMBLPlaceManagerDelegate>
@property GMBLBeaconManager* beaconManager;
@property GMBLCommunicationManager* communicationManager;
@property NSDictionary* sighting;
@property NSString* global_distinct_id;
@property NSString* mobile_device_ios_idfa;
@property (nonatomic, strong) DSIOAPI* api;
@property NSString* gimbalApiKey;
- (void)startGimbal;
@end
