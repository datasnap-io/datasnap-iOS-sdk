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
                         name:(NSString*)name
                  bleVendorId:(NSString*)bleVendorId
{
    self.identifier = identifier;
    self.name = name;
    self.bleVendorId = bleVendorId;
    return self;
}
- (Beacon*)initWithIdentifier:(NSString*)identifier
{
    self.identifier = identifier;
    return self;
}
@end
