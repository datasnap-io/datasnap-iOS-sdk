//
//  DSIOVendorProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Gimbal/Gimbal.h>
typedef enum {
    GIMBAL,
    ESTIMOTE
} Vendor;
@interface DSIOVendorProperties : NSObject
@property Vendor vendor;
@property NSString* gimbalApiKey;
@property GMBLBeaconManager* beaconManager;
@end
