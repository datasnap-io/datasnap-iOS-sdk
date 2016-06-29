//
//  DSIOVendorProperties.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "VendorProperties.h"

@implementation VendorProperties
@synthesize gimbalApiKey;
@synthesize vendor;
- (VendorProperties*)initWithVendor:(Vendor)vendor
                    andgimbalApiKey:(NSString*)gimbalApiKey
{
    self.vendor = vendor;
    self.gimbalApiKey = gimbalApiKey;
}
@end
