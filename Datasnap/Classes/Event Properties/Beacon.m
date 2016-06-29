//
//  Beacon.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Beacon.h"

@implementation Beacon
@synthesize identifier;
@synthesize uuid;
@synthesize name;
@synthesize batteryLevel;
@synthesize temperature;
@synthesize bleVendorUuid;
@synthesize bleVendorId;
@synthesize rssi;
@synthesize isMobile;
@synthesize previousRssi;
@synthesize dwellTime;
@synthesize startTime;
@synthesize lastUpdateTime;
@synthesize latitude;
@synthesize longitude;
@synthesize visibility;
@synthesize hardware;
@synthesize tags;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"id" : self.identifier,
        @"uuid" : self.uuid,
        @"name" : self.name,
        @"battery_level" : self.batteryLevel ? self.batteryLevel : [NSNull null],
        @"temperature" : self.temperature ? self.temperature : [NSNull null],
        @"ble_vendor_id" : self.bleVendorId ? self.bleVendorId : [NSNull null],
        @"ble_vendor_uuid" : self.bleVendorUuid ? self.bleVendorUuid : [NSNull null],
        @"rssi" : self.rssi,
        @"is_mobile" : self.isMobile ? self.isMobile : [NSNull null],
        @"previous_rssi" : self.previousRssi ? self.previousRssi : [NSNull null],
        @"dwell_time" : self.dwellTime ? self.dwellTime : [NSNull null],
        @"start_time" : self.startTime ? self.startTime : [NSNull null],
        @"last_update_time" : self.lastUpdateTime ? self.lastUpdateTime : [NSNull null],
        @"latitude" : self.latitude ? self.latitude : [NSNull null],
        @"longitude" : self.longitude ? self.longitude : [NSNull null],
        @"visibility" : self.visibility ? self.visibility : [NSNull null],
        @"hardware" : self.hardware ? self.hardware : [NSNull null],
        @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
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
                         tags:(Tags*)tags
{
    self.identifier = identifier;
    self.uuid = uuid;
    self.name = name;
    self.batteryLevel = batteryLevel;
    self.temperature = temperature;
    self.bleVendorUuid = bleVendorUuid;
    self.bleVendorId = bleVendorId;
    self.rssi = rssi;
    self.isMobile = isMobile;
    self.previousRssi = previousRssi;
    self.dwellTime = dwellTime;
    self.startTime = startTime;
    self.lastUpdateTime = lastUpdateTime;
    self.latitude = latitude;
    self.longitude = longitude;
    self.visibility = visibility;
    self.hardware = hardware;
    self.tags = tags;
    return self;
}
@end
