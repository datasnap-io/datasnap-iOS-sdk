//
//  Copyright (c) 2015 Datasnap.io. All rights reserved.
//

#import "DSIOAPI.h"

static NSString *const URLReservedChars     = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString *const kQuerySeparator  = @"&";
static NSString *const kQueryDivider    = @"=";
static NSString *const kQueryBegin      = @"?";
static NSString *const kFragmentBegin   = @"#";


static NSString *const kDataSnapEventAPIURL = @"https://api-events.datasnap.io/v1.0/events";


@interface DSIOAPI () <NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *secret;

@end

@implementation DSIOAPI

- (instancetype)initWithKey: (NSString *) apiKey secret: (NSString *) apiSecret
{
    self = [super init];
    if (self) {
        self.key = apiKey;
        self.secret = apiSecret;
    }
    return self;
}

- (void)sendEvents:(NSObject *)events {
    
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:events
                                                   options:0
                                                     error:&error];
    if(error)
    {
        json = [NSData new];
    }
    
    NSURL *url = [NSURL URLWithString:kDataSnapEventAPIURL];
    
    [self performAuthenticatedPOSTRequestWithURL:url
                                            body:json
                                    onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                        if(error)
                                        {
                                            NSLog(@"An error occured sending DataSnap events");
                                        }
                                    }];
}

- (void) performAuthenticatedPOSTRequestWithURL: (NSURL *) requestURL body: (NSData *) data onCompletion: (DataSnapAPIRequestCompleted) completitionHandler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    [self performAuthenticatedRequest:request onCompletion:completitionHandler];
}


- (void) performAuthenticatedGETRequestWithURL: (NSURL *) requestURL parameters: (NSDictionary *) params onCompletion: (DataSnapAPIRequestCompleted) completitionHandler
{
    NSURL *newURL = [self urlWithURL:requestURL withQueryDictionary:params sortKeys:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:newURL];
    [request setHTTPMethod:@"GET"];
    
    [self performAuthenticatedRequest:request onCompletion:completitionHandler];
}



- (void) performAuthenticatedRequest: (NSURLRequest *) request onCompletion: (DataSnapAPIRequestCompleted) completitionHandler
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders: @{
                                               @"Accept": @"application/json",
                                               @"Authorization" : [self __authorizationHeader]
                                               }];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if(completitionHandler) {
                                          completitionHandler(data, response, error);
                                      }
                                  }];
    
    [task resume];
}



#pragma mark - Private Methods

- (NSString *) __authorizationHeader
{
    NSData *authData = [[NSString stringWithFormat:@"%@:%@", self.key, self.secret] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authString = [authData base64EncodedStringWithOptions:0];
    return [NSString stringWithFormat: @"Basic %@", authString];
}

- (NSURL *) urlWithURL: (NSURL *) url withQueryDictionary: (NSDictionary *) queryDictionary sortKeys: (BOOL) sortedKeys
{
    NSMutableArray *queries = [url.query length] > 0 ? @[url.query].mutableCopy : @[].mutableCopy;
    NSString *dictionaryQuery = [self queryStringWithDictionary:queryDictionary sortedKeys:sortedKeys escape:YES];
    if (dictionaryQuery) {
        [queries addObject:dictionaryQuery];
    }
    NSString *newQuery = [queries componentsJoinedByString:kQuerySeparator];
    
    if (newQuery.length) {
        NSArray *queryComponents = [url.absoluteString componentsSeparatedByString:kQueryBegin];
        if (queryComponents.count) {
            return [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@%@%@%@%@",
                     queryComponents[0],                      // existing url
                     kQueryBegin,
                     newQuery,
                     url.fragment.length ? kFragmentBegin : @"",
                     url.fragment.length ? url.fragment : @""]];
        }
    }
    return url;
}
- (NSString *) queryStringWithDictionary: (NSDictionary *) dict sortedKeys: (BOOL) sortedKeys escape: (BOOL) escape
{
    NSMutableString *queryString = @"".mutableCopy;
    NSArray *keys = sortedKeys ? [dict.allKeys sortedArrayUsingSelector:@selector(compare:)] : dict.allKeys;
    for (NSString *key in keys) {
        id rawValue = dict[key];
        NSString *value = nil;
        // beware of empty or null
        if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
            if(escape) {
                value = URLEscape([dict[key] description]);
            }
            else {
                value = [dict[key] description];
            }
        }
        [queryString appendFormat:@"%@%@%@%@",
         queryString.length ? kQuerySeparator : @"",    // appending?
         escape ? URLEscape(key) : key,
         value ? kQueryDivider : @"",
         value ? value : @""];
    }
    return queryString.length ? queryString.copy : nil;
}

static inline NSString *URLEscape(NSString *string) {
    return ((__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)string,
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)URLReservedChars,
                                                                                  kCFStringEncodingUTF8));
}


@end
