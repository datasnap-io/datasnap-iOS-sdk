//
//  Datasnap.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOConfig.h"
#import "DatasnapAPI.h"
#import "Device.h"
#import "GeofenceEvent.h"
#import "GimbalClient.h"
#import "User.h"
#import "VendorProperties.h"
#import <AFNetworking/AFNetworking.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

@class BaseEvent;
@interface Datasnap : NSObject
@property (nonatomic) EventEntity* event;
@property (nonatomic) Device* device;
@property (nonatomic, strong) DeviceInfo* deviceInfo;
@property (nonatomic, strong) User* user;
@property (nonatomic) Identifier* identifier;
@property (nonatomic) VendorProperties* vendorProperties;
@property (nonatomic) GimbalClient* gimbalClient;
@property (nonatomic, strong) NSString* organizationId;
@property (nonatomic, strong) NSString* projectId;
@property (nonatomic) DatasnapAPI* api;
@property (nonatomic) EventQueue* eventQueue;
@property (nonatomic) GMBLBeaconManager* beaconManager;
@property (nonatomic) BaseClient* baseClient;
@property (nonatomic) NSTimer* timer;
@property (nonatomic) bool optIn;
@property (nonatomic) NSString* email;
- (void)trackEvent:(BaseEvent*)event;
+ (id)sharedClient;
- (void)genericEvent:(NSDictionary*)eventDetails;
- (id)initWithApiKey:(NSString*)apiKey
        apiKeySecret:(NSString*)apiKeySecret
      organizationId:(NSString*)organizationId
           projectId:(NSString*)projectId
           idfaOptIn:(bool)optIn
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties;
- (void)setFlushParamsWithDuration:(NSInteger)durationInMillis
                   withMaxElements:(NSInteger)maxElements;
@end
