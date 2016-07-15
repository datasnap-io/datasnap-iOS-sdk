//
//  Copyright (c) 2015 Datasnap.io. All rights reserved.
//

#import "DSIOConfig.h"
#import "DatasnapAPI.h"

static NSString* const URLReservedChars = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString* const kQuerySeparator = @"&";
static NSString* const kQueryDivider = @"=";
static NSString* const kQueryBegin = @"?";
static NSString* const kFragmentBegin = @"#";

static NSString* const kDataSnapEventAPIURL = @"https://api-events.datasnap.io/v1.0/events";

@interface DatasnapAPI () <NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSString* secret;

@end

@implementation DatasnapAPI

- (instancetype)initWithKey:(NSString*)apiKey secret:(NSString*)apiSecret
{
    self = [super init];
    if (self) {
        self.key = apiKey;
        self.secret = apiSecret;
    }
    return self;
}

- (BOOL)sendEvents:(NSObject*)events
{
    NSError* error;
    NSData* json = [NSJSONSerialization dataWithJSONObject:events
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    NSData* compressedJson = [GZip gzipData:json];
    if (error) {
        json = [NSData new];
    }

    __block NSString* jsonStr = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    NSURL* url = [NSURL URLWithString:kDataSnapEventAPIURL];

    [self performAuthenticatedPOSTRequestWithURL:url
                                            body:compressedJson
                                    onCompletion:^(NSData* data, NSURLResponse* response, NSError* error) {
                                        if (error) {
                                            DSIOLog(@"Error sending request to %@.\n", url);
                                            DSIOLog(@"%@", jsonStr);
                                            DSIOLog(@"%@\n", error.description);
                                            self.status = NO;
                                        }
                                        else if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
                                            NSHTTPURLResponse* resp = (NSHTTPURLResponse*)response;
                                            if (resp.statusCode == 401) {
                                                DSIOLog(@"Datasnap Error: Please check network connection on the device and that the datasnap api keys have been entered correctly");
                                                self.status = NO;
                                            }
                                            else if (resp.statusCode > 204) {
                                                NSLog(@"Received a failed response from the Datasnap server. Status Code %d", resp.statusCode);
                                                NSLog(@"%@", response);
                                                NSLog(@"%@", jsonStr);
                                                self.status = NO;
                                            }
                                            else {
                                                NSLog(@"Request successfully sent to %@.\nStatus code: %d.\n", url, resp.statusCode);
                                                self.status = YES;
                                            }
                                        }

                                    }];
    return self.status;
}

- (void)performAuthenticatedPOSTRequestWithURL:(NSURL*)requestURL body:(NSData*)data onCompletion:(DataSnapAPIRequestCompleted)completitionHandler
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];

    [self performAuthenticatedRequest:request onCompletion:completitionHandler];
}

- (void)performAuthenticatedGETRequestWithURL:(NSURL*)requestURL parameters:(NSDictionary*)params onCompletion:(DataSnapAPIRequestCompleted)completitionHandler
{
    NSURL* newURL = [self urlWithURL:requestURL withQueryDictionary:params sortKeys:YES];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:newURL];
    [request setHTTPMethod:@"GET"];

    [self performAuthenticatedRequest:request onCompletion:completitionHandler];
}

- (void)performAuthenticatedRequest:(NSURLRequest*)request onCompletion:(DataSnapAPIRequestCompleted)completitionHandler
{
    NSMutableURLRequest* req = [request mutableCopy];
    [req addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:@{
        @"Content-Type" : @"application/json",
        @"Authorization" : [self __authorizationHeader],
        @"Content-Encoding" : @"gzip"
    }];

    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];

    NSURLSessionDataTask* task = [session dataTaskWithRequest:req
                                            completionHandler:
                                                ^(NSData* data, NSURLResponse* response, NSError* error) {
                                                    if (completitionHandler) {
                                                        completitionHandler(data, response, error);
                                                    }
                                                }];

    [task resume];
}

#pragma mark - Private Methods

- (NSString*)__authorizationHeader
{
    NSData* authData = [[NSString stringWithFormat:@"%@:%@", self.key, self.secret] dataUsingEncoding:NSUTF8StringEncoding];
    NSString* authString = [authData base64EncodedStringWithOptions:0];
    return [NSString stringWithFormat:@"Basic %@", authString];
}

- (NSURL*)urlWithURL:(NSURL*)url withQueryDictionary:(NSDictionary*)queryDictionary sortKeys:(BOOL)sortedKeys
{
    NSMutableArray* queries = [url.query length] > 0 ? @[ url.query ].mutableCopy : @[].mutableCopy;
    NSString* dictionaryQuery = [self queryStringWithDictionary:queryDictionary sortedKeys:sortedKeys escape:YES];
    if (dictionaryQuery) {
        [queries addObject:dictionaryQuery];
    }
    NSString* newQuery = [queries componentsJoinedByString:kQuerySeparator];

    if (newQuery.length) {
        NSArray* queryComponents = [url.absoluteString componentsSeparatedByString:kQueryBegin];
        if (queryComponents.count) {
            return [NSURL URLWithString:
                              [NSString stringWithFormat:@"%@%@%@%@%@",
                                        queryComponents[0], // existing url
                                        kQueryBegin,
                                        newQuery,
                                        url.fragment.length ? kFragmentBegin : @"",
                                        url.fragment.length ? url.fragment : @""]];
        }
    }
    return url;
}
- (NSString*)queryStringWithDictionary:(NSDictionary*)dict sortedKeys:(BOOL)sortedKeys escape:(BOOL)escape
{
    NSMutableString* queryString = @"".mutableCopy;
    NSArray* keys = sortedKeys ? [dict.allKeys sortedArrayUsingSelector:@selector(compare:)] : dict.allKeys;
    for (NSString* key in keys) {
        id rawValue = dict[key];
        NSString* value = nil;
        // beware of empty or null
        if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
            if (escape) {
                value = URLEscape([dict[key] description]);
            }
            else {
                value = [dict[key] description];
            }
        }
        [queryString appendFormat:@"%@%@%@%@",
                     queryString.length ? kQuerySeparator : @"", // appending?
                     escape ? URLEscape(key) : key,
                     value ? kQueryDivider : @"",
                     value ? value : @""];
    }
    return queryString.length ? queryString.copy : nil;
}

static inline NSString* URLEscape(NSString* string)
{
    return ((__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (__bridge CFStringRef)string,
        NULL,
        (__bridge CFStringRef)URLReservedChars,
        kCFStringEncodingUTF8));
}

@end
