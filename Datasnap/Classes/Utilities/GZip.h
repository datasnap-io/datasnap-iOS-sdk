//
//  DSIOGZip.h
//  Datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/22/16.
//  Copyright © 2016 Datasnap. All rights reserved.
//

#import "zlib.h"
#import <Foundation/Foundation.h>

@interface GZip : NSObject
+ (NSData*)gzipData:(NSData*)pUncompressedData;
@end
