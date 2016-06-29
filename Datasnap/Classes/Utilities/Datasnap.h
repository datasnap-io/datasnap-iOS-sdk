//
//  Datasnap.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseClient.h"
#import "BeaconEvent.h"
#import "DSIOConfig.h"
#import "DatasnapAPI.h"
#import "Device.h"
#import "Event+Management.h"
#import "EventQueue.h"
#import "GeofenceEvent.h"
#import "GimbalClient.h"
#import "NSString+Helpers.h"
#import "User.h"
#import "VendorProperties.h"
#import <AFNetworking/AFNetworking.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseEvent;
@interface Datasnap : NSObject
@property (nonatomic) EventEntity* event;
@property (nonatomic) Device* device;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) Identifier* identifier;
@property (nonatomic) VendorProperties* vendorProperties;
@property (nonatomic) GimbalClient* gimbalClient;
@property (nonatomic, strong) NSString* organizationId;
@property (nonatomic, strong) NSString* projectId;
@property (nonatomic) DatasnapAPI* api;
@property (nonatomic) EventQueue* eventQueue;
@property (nonatomic) GMBLBeaconManager* beaconManager;
@property (nonatomic) BaseClient* baseClient;
@property (nonatomic) NSTimer* timer;
@property (nonatomic) bool googleAdOptIn;
@property (nonatomic) NSString* email;
@property (nonatomic) NSString* mobileDeviceIosIdfa;
- (void)trackEvent:(BaseEvent*)event;
+ (id)sharedClient;
- (void)genericEvent:(NSDictionary*)eventDetails;
- (id)initWithApiKey:(NSString*)apiKey
        apiKeySecret:(NSString*)apiKeySecret
      organizationId:(NSString*)organizationId
           projectId:(NSString*)projectId
       googleAdOptIn:(bool)googleAdOptIn
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties;
- (void)setFlushParamsWithDuration:(NSInteger)durationInMillis
                   withMaxElements:(NSInteger)maxElements;
@end
