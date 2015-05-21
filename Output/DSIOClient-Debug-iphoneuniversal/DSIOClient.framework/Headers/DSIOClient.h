//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>

//! Project version number for DSIOClient.
FOUNDATION_EXPORT double DSIOClientVersionNumber;

//! Project version string for DSIOClient.
FOUNDATION_EXPORT const unsigned char DSIOClientVersionString[];

@interface DSIOClient : NSObject

+ (void)setupWithOrgID:(NSString *)organizationID
             projectId:(NSString *)projectID
                APIKey:(NSString *)APIKey
             APISecret:(NSString *)APISecret
               logging:(BOOL)logging
              eventNum:(int)eventNum;

/**
Event Handlers
*/
- (void)flushEvents;
- (void)genericEvent:(NSMutableDictionary *)eventDetails;
- (void)geofenceEvent:(NSMutableDictionary *)eventDetails;
- (void)beaconEvent:(NSMutableDictionary *)eventDetails;
- (void)eventHandler:(NSMutableDictionary *)eventDetails;
- (void)globalPositionEvent:(NSMutableDictionary *)eventDetails;
- (void)placeEvent:(NSMutableDictionary *)eventDetails;
- (void)communicationEvent:(NSMutableDictionary *)eventDetails;
- (void)campaignEvent:(NSMutableDictionary *)eventDetails;

//Enable Logging
+ (void)debug:(BOOL)showDebugLogs;

+ (id)sharedClient;

@end
