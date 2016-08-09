//
//  DSIOVendorProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/10/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef enum {
    GIMBAL,
    ESTIMOTE
} Vendor;
@interface VendorProperties : NSObject
@property Vendor vendor;
@property NSString* gimbalApiKey;
- (VendorProperties*)initWithVendor:(Vendor)vendor
                    andgimbalApiKey:(NSString*)gimbalApiKey;
@end
