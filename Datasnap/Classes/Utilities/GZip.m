//
//  DSIOGZip.m
//  Datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/22/16.
//  Copyright © 2016 Datasnap. All rights reserved.
//

#import "GZip.h"

@implementation GZip
+ (NSData*)gzipData:(NSData*)pUncompressedData
{
    if (!pUncompressedData || [pUncompressedData length] == 0) {
        NSLog(@"%s: Error: Can't compress an empty or null NSData object.", __func__);
        return nil;
    }
    z_stream zlibStreamStruct;
    //set zalloc, zfree, and opaque to Z_NULL so that when deflateInit2 is called they will be updated to use default allocation functions
    zlibStreamStruct.zalloc = Z_NULL;
    zlibStreamStruct.zfree = Z_NULL;
    zlibStreamStruct.opaque = Z_NULL;
    //total number of output bytes
    zlibStreamStruct.total_out = 0;
    //pointer to input bytes
    zlibStreamStruct.next_in = (Bytef*)[pUncompressedData bytes];
    //number of input bytes left to process
    zlibStreamStruct.avail_in = (uint)[pUncompressedData length];

    //Z_DEFAULT_COMPRESSION = compression level
    //Z_DEFLATED = method of compression
    //Z_DEFAULT_STRATEGY = strategy to tune compression algorithm
    int initError = deflateInit2(&zlibStreamStruct, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15 + 16), 8, Z_DEFAULT_STRATEGY);
    if (initError != Z_OK) {
        NSString* errorMsg = nil;
        switch (initError) {
        case Z_STREAM_ERROR:
            errorMsg = @"Invalid parameter passed in to function.";
            break;
        case Z_MEM_ERROR:
            errorMsg = @"Insufficient memory.";
            break;
        case Z_VERSION_ERROR:
            errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
            break;
        default:
            errorMsg = @"Unknown error code.";
            break;
        }
        NSLog(@"%s: deflateInit2() Error: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        return nil;
    }
    NSMutableData* compressedData = [NSMutableData dataWithLength:[pUncompressedData length] * 1.01 + 12];

    int deflateStatus;
    do {
        //location where next byte should be put in next_out
        zlibStreamStruct.next_out = [compressedData mutableBytes] + zlibStreamStruct.total_out;
        //the amount of remaining free space in output buffer
        zlibStreamStruct.avail_out = (uint)[compressedData length] - (uint)zlibStreamStruct.total_out;
        //deflate() compresses as much data as possible.
        deflateStatus = deflate(&zlibStreamStruct, Z_FINISH);
        //Z_OK status means output buffer is full but more data is left in the input
    } while (deflateStatus == Z_OK);

    //Z_STREAM_END status means all of the data has been compressed
    if (deflateStatus != Z_STREAM_END) {
        // Check for zlib error and convert code to usable error message if appropriate
        NSString* errorMsg = nil;
        switch (deflateStatus) {
        case Z_ERRNO:
            errorMsg = @"Error occured while reading file.";
            break;
        case Z_STREAM_ERROR:
            errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL).";
            break;
        case Z_DATA_ERROR:
            errorMsg = @"The deflate data was invalid or incomplete.";
            break;
        case Z_MEM_ERROR:
            errorMsg = @"Memory could not be allocated for processing.";
            break;
        case Z_BUF_ERROR:
            errorMsg = @"Ran out of output buffer for writing compressed bytes.";
            break;
        case Z_VERSION_ERROR:
            errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
            break;
        default:
            errorMsg = @"Unknown error code.";
            break;
        }
        NSLog(@"%s: zlib error while attempting compression: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        // Free data structures that were dynamically created for the stream.
        deflateEnd(&zlibStreamStruct);
        return nil;
    }
    // Free data structures that were dynamically created for the stream.
    deflateEnd(&zlibStreamStruct);
    [compressedData setLength:zlibStreamStruct.total_out];
    return compressedData;
}

@end
