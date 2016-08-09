//
//  Datasnap.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#pragma mark event types
#import "BaseEvent.h"
#import "BeaconEvent.h"
#import "CommunicationEvent.h"
#import "GeofenceEvent.h"
#import "GlobalPositionEvent.h"
#import "SDKErrorEvent.h"
#pragma mark utilities
#import "BaseClient.h"
#import "DSIOConfig.h"
#import "DatasnapAPI.h"
#import "EventQueue.h"
#import "GZip.h"
#import "NSString+Helpers.h"
#import "VendorProperties.h"
#pragma mark event properties
#import "Beacon.h"
#import "Campaign.h"
#import "Communication.h"
#import "Device.h"
#import "Geofence.h"
#import "Identifier.h"
#import "User.h"
#pragma mark model
#import "Event+Management.h"
#pragma mark frameworks
#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseEvent;
@interface Datasnap : NSObject
@property (nonatomic) DatasnapAPI* api;
@property (nonatomic) EventQueue* eventQueue;
@property (nonatomic) NSString* email;
@property (nonatomic) NSString* UUID;
- (void)trackEvent:(BaseEvent*)event;
+ (id)sharedClient;
- (id)initWithApiKey:(NSString*)apiKey
        apiKeySecret:(NSString*)apiKeySecret
      organizationId:(NSString*)organizationId
           projectId:(NSString*)projectId
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties;
- (void)setFlushParamsWithDuration:(NSInteger)durationInMillis
                   withMaxElements:(NSInteger)maxElements;
- (void)checkQueue;
- (BOOL)connected;
@end
