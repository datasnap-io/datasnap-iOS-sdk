//
//  DSIOGZip.h
//  DSIODatasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/22/16.
//  Copyright © 2016 DSIODatasnap. All rights reserved.
//

#import "zlib.h"
#import <Foundation/Foundation.h>

@interface DSIOGZip : NSObject
+ (NSData*)gzipData:(NSData*)pUncompressedData;
@end
