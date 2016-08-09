//
//  GimbalClient.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/1/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseClient.h"
#import <Gimbal/Gimbal.h>

@interface GimbalClient : BaseClient <GMBLBeaconManagerDelegate, GMBLCommunicationManagerDelegate, GMBLPlaceManagerDelegate>
@property GMBLBeaconManager* beaconManager;
@property GMBLCommunicationManager* communicationManager;
@property NSDictionary* sighting;
@property NSString* gimbalApiKey;
- (GimbalClient*)initWithVendorProperties:(VendorProperties*)vendorProperties
                           organizationId:(NSString*)organizationId
                                projectId:(NSString*)projectId;
- (void)startGimbal;
@end
