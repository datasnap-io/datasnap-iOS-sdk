//
//  Beacon.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

// Where are we using runtime.h?
#import <objc/runtime.h>

@interface Beacon
@property NSString* name;
@property NSString* bleVendorId;
@property NSString* identifier;
// Minimum needed to create a beacon
- (Beacon*)initWithIdentifier:(NSString*)identifier;
// Most we'd ever need to create a beacon
- (Beacon*)initWithIdentifier:(NSString*)identifier
                         name:(NSString*)name
                  bleVendorId:(NSString*)bleVendorId;
@end