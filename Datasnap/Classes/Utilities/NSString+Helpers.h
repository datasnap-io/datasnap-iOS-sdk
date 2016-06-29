//
//  NSString+Helpers.h
//  Pods
//
//  Created by Alyssa McIntyre on 6/29/16.
//
//
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface NSString (Helpers)
- (NSString*)toSha1:(NSString*)input;
@end
