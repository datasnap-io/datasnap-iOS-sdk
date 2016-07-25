//
//  Beacon.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"

@interface Beacon : EventProperty
@property NSString* name;
@property NSString* bleVendorId;
@property NSString* identifier;
@property NSString* battery_level;
@property NSString* rssi;
// Minimum needed to create a beacon
- (Beacon*)initWithIdentifier:(NSString*)identifier;
// Most we'd ever need to create a beacon
- (Beacon*)initWithIdentifier:(NSString*)identifier
                         name:(NSString*)name
                  bleVendorId:(NSString*)bleVendorId;
@end