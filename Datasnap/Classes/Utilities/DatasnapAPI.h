//
//  Copyright (c) 2015 Datasnap.io. All rights reserved.
//

#import "Device.h"
#import "Event+Management.h"
#import "EventQueue.h"
#import "Gzip.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Foundation/Foundation.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

typedef void (^DataSnapAPIRequestCompleted)(NSData* data, NSURLResponse* response, NSError* error);
typedef void (^Completion)(BOOL);
@interface DatasnapAPI : NSObject
@property BOOL status;
- (instancetype)initWithKey:(NSString*)apiKey secret:(NSString*)apiSecret;
- (void)sendEvents:(NSObject*)events andBlock:(Completion)completionBlock;
- (void)performAuthenticatedPOSTRequestWithURL:(NSURL*)requestURL body:(NSData*)data onCompletion:(DataSnapAPIRequestCompleted)completitionHandler;
- (void)performAuthenticatedGETRequestWithURL:(NSURL*)requestURL parameters:(NSDictionary*)params onCompletion:(DataSnapAPIRequestCompleted)completitionHandler;
- (void)performAuthenticatedRequest:(NSURLRequest*)request onCompletion:(DataSnapAPIRequestCompleted)completitionHandler;
@end
