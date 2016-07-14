//
//  Beacon.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "Tags.h"
#import <objc/runtime.h>

@interface Beacon : EventProperty
@property NSString* uuid;
@property NSString* name;
@property NSString* batteryLevel;
@property NSString* temperature;
@property NSString* bleVendorUuid;
@property NSString* bleVendorId;
@property NSString* rssi;
@property NSString* isMobile;
@property NSString* previousRssi;
@property NSString* dwellTime;
@property NSString* startTime;
@property NSString* lastUpdateTime;
@property NSString* latitude;
@property NSString* longitude;
@property NSString* visibility;
@property NSString* hardware;
@property Tags* tags;
- (Beacon*)initWithIdentifier:(NSString*)identifier
                         uuid:(NSString*)uuid
                         name:(NSString*)name
                 batterylevel:(NSString*)batteryLevel
                  temperature:(NSString*)temperature
                bleVendorUuid:(NSString*)bleVendorUuid
                  bleVendorId:(NSString*)bleVendorId
                         rssi:(NSString*)rssi
                     isMobile:(NSString*)isMobile
                 previousRssi:(NSString*)previousRssi
                    dwellTime:(NSString*)dwellTime
                    startTime:(NSString*)startTime
               lastUpdateTime:(NSString*)lastUpdateTime
                     latitude:(NSString*)latitude
                    longitude:(NSString*)longitude
                   visibility:(NSString*)visibility
                     hardware:(NSString*)hardware
                         tags:(Tags*)tags;
@end
