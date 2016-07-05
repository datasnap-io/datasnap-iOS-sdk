//
//  Copyright (c) 2015 Datasnap.io. All rights reserved.
//

#import "Gzip.h"
#import <Foundation/Foundation.h>

typedef void (^DataSnapAPIRequestCompleted)(NSData* data, NSURLResponse* response, NSError* error);

@interface DatasnapAPI : NSObject
@property bool success;
- (instancetype)initWithKey:(NSString*)apiKey secret:(NSString*)apiSecret;

- (BOOL)sendEvents:(NSObject*)events;

- (void)performAuthenticatedPOSTRequestWithURL:(NSURL*)requestURL body:(NSData*)data onCompletion:(DataSnapAPIRequestCompleted)completitionHandler;
- (void)performAuthenticatedGETRequestWithURL:(NSURL*)requestURL parameters:(NSDictionary*)params onCompletion:(DataSnapAPIRequestCompleted)completitionHandler;
- (void)performAuthenticatedRequest:(NSURLRequest*)request onCompletion:(DataSnapAPIRequestCompleted)completitionHandler;
@end
