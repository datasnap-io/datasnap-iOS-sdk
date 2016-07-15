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
                     latitude:(NSString*)latitude
                    longitude:(NSString*)longitude
{
    self.identifier = identifier;
    self.uuid = uuid;
    self.name = name;
    self.batteryLevel = batteryLevel;
    self.temperature = temperature;
    self.bleVendorUuid = bleVendorUuid;
    self.bleVendorId = bleVendorId;
    self.rssi = rssi;
    self.latitude = latitude;
    self.longitude = longitude;
    return self;
}
@end
