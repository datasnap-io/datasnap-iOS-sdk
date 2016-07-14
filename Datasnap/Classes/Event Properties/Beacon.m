//
//  Beacon.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Beacon.h"

@implementation Beacon

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
