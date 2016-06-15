//
//  DataSnap.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOConfig.h"
#import "DSIOGimbalClient.h"
#import "Device.h"
#import "User.h"
#import "VendorProperties.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
@class BaseEvent;
@interface DataSnap : NSObject
@property (nonatomic) EventEntity* event;
@property (nonatomic) Device* device;
@property (nonatomic, strong) DeviceInfo* deviceInfo;
@property (nonatomic, strong) User* user;
@property (nonatomic) Identifier* identifier;
@property (nonatomic) VendorProperties* vendorProperties;
@property (nonatomic) DSIOGimbalClient* gimbalClient;
@property (nonatomic, strong) NSString* organizationId;
@property (nonatomic, strong) NSString* projectId;
@property (nonatomic) DSIOAPI* api;
@property (nonatomic) DSIOEventQueue* eventQueue;
@property (nonatomic) GMBLBeaconManager* beaconManager;
@property (nonatomic) DSIOBaseClient* baseClient;
- (void)trackEvent:(BaseEvent*)event;
+ (id)sharedClient;
- (void)genericEvent:(NSDictionary*)eventDetails;
+ (void)setUpDataSnapWithApiKey:(NSString*)apiKey
                   apiKeySecret:(NSString*)apiKeySecret
                 organizationId:(NSString*)organizationId
                      projectId:(NSString*)projectId
                 eventQueueSize:(NSInteger)eventNum
            andVendorProperties:(VendorProperties*)vendorProperties;
@end
