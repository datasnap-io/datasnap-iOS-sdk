//
//  NSString+Helpers.m
//  Pods
//
//  Created by Alyssa McIntyre on 6/29/16.
//
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)
- (NSString*)toSha1
{
    const char* cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [NSData dataWithBytes:cstr length:self.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, data.length, digest);

    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}
@end
