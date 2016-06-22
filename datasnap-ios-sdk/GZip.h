//
//  GZip.h
//  datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/22/16.
//  Copyright © 2016 DataSnap. All rights reserved.
//

#import "zlib.h"
#import <Foundation/Foundation.h>

@interface GZip : NSObject
+ (NSData*)gzipData:(NSData*)pUncompressedData;
@end
