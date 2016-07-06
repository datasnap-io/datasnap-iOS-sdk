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
#import "InteractionEvent.h"
#import "UpdateEvent.h"
#pragma mark utilities
#import "BaseClient.h"
#import "DSIOConfig.h"
#import "DatasnapAPI.h"
#import "EventQueue.h"
#import "GZip.h"
#import "NSString+Helpers.h"
#import "VendorProperties.h"
#pragma mark event properties
#import "Audience.h"
#import "Beacon.h"
#import "Campaign.h"
#import "Communication.h"
#import "Content.h"
#import "DefaultProperties.h"
#import "Device.h"
#import "EventProperty.h"
#import "Geofence.h"
#import "GeofenceCircle.h"
#import "GlobalPosition.h"
#import "Identifier.h"
#import "Location.h"
#import "Place.h"
#import "Tags.h"
#import "Types.h"
#import "User.h"
#import "UserProperties.h"
#pragma mark model
#import "Event+Management.h"
#pragma mark frameworks
#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseEvent;
@interface Datasnap : NSObject
@property (nonatomic) DatasnapAPI* api;
- (void)trackEvent:(BaseEvent*)event;
+ (id)sharedClient;
- (id)initWithApiKey:(NSString*)apiKey
        apiKeySecret:(NSString*)apiKeySecret
      organizationId:(NSString*)organizationId
           projectId:(NSString*)projectId
           IDFAOptIn:(bool)googleAdOptIn
               email:(NSString*)email
 andVendorProperties:(VendorProperties*)vendorProperties;
- (void)setFlushParamsWithDuration:(NSInteger)durationInMillis
                   withMaxElements:(NSInteger)maxElements;
- (void)checkQueue;
- (BOOL)connected;
@end
