//
//  GimbalClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseClient.h"
#import "BeaconEvent.h"
#import "Campaign.h"
#import "Communication.h"
#import "CommunicationEvent.h"
#import "DatasnapAPI.h"
#import "EventQueue.h"
#import <Gimbal/Gimbal.h>

@interface GimbalClient : BaseClient <GMBLBeaconManagerDelegate, GMBLCommunicationManagerDelegate, GMBLPlaceManagerDelegate>
@property GMBLBeaconManager* beaconManager;
@property GMBLCommunicationManager* communicationManager;
@property NSDictionary* sighting;
@property NSString* global_distinct_id;
@property NSString* mobile_device_ios_idfa;
@property (nonatomic, strong) DatasnapAPI* api;
@property NSString* gimbalApiKey;
- (void)startGimbal;
@end
