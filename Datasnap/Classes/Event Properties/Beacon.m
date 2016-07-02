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
- (Beacon*)initWithSighting:(GMBLBeaconSighting*)sighting
{
    self.identifier = sighting.beacon.identifier;
    self.uuid = sighting.beacon.uuid;
    self.name = sighting.beacon.name;
    self.batteryLevel = [NSString stringWithFormat:@"%ld", (long)sighting.beacon.batteryLevel];
    self.temperature = [NSString stringWithFormat:@"%d", sighting.beacon.temperature];
    self.rssi = [NSString stringWithFormat:@"%d", sighting.RSSI];
    self.bleVendorId = @"Gimbal";

    return self;
}

@end
