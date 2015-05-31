//
//  DSIOAPI.h
//  datasnap-ios-mediation-sdk
//
//  Created by Nolan Brown on 5/28/15.
//  Copyright (c) 2015 Datasnap.io. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DataSnapAPIRequestCompleted) (NSData *data, NSURLResponse *response, NSError *error);


@interface DSIOAPI : NSObject

- (instancetype)initWithKey: (NSString *) apiKey secret: (NSString *) apiSecret;

- (void)sendEvents:(NSObject *)events;

- (void) performAuthenticatedPOSTRequestWithURL: (NSURL *) requestURL body: (NSData *) data onCompletion: (DataSnapAPIRequestCompleted) completitionHandler;
- (void) performAuthenticatedGETRequestWithURL: (NSURL *) requestURL parameters: (NSDictionary *) params onCompletion: (DataSnapAPIRequestCompleted) completitionHandler;
- (void) performAuthenticatedRequest: (NSURLRequest *) request onCompletion: (DataSnapAPIRequestCompleted) completitionHandler;
@end
