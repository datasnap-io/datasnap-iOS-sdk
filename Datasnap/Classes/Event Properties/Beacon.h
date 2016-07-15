//
//  Beacon.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import <objc/runtime.h>

@interface Beacon : EventProperty
@property NSString* uuid;
@property NSString* name;
@property NSString* batteryLevel;
@property NSString* temperature;
@property NSString* bleVendorUuid;
@property NSString* bleVendorId;
@property NSString* rssi;
@property NSString* latitude;
@property NSString* longitude;
@property NSString* identifier;
- (Beacon*)initWithIdentifier:(NSString*)identifier
                         uuid:(NSString*)uuid
                         name:(NSString*)name
                 batterylevel:(NSString*)batteryLevel
                  temperature:(NSString*)temperature
                bleVendorUuid:(NSString*)bleVendorUuid
                  bleVendorId:(NSString*)bleVendorId
                         rssi:(NSString*)rssi
                     latitude:(NSString*)latitude
                    longitude:(NSString*)longitude;
@end
