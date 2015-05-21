//
// Copyright (c) 2015 Datasnapio. All rights reserved.
//

#import "DSIORequest.h"
#import "DSIOConfig.h"

@interface DSIORequest ()

@property NSString *url;
@property NSString *authString;
@property NSOperationQueue *queue;

@end

@implementation DSIORequest

- (id)initWithURL:(NSString *)url authString:(NSString *)authString {
    if (self = [super init]) {
        self.url = url;
        self.authString = authString;
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)sendEvents:(NSObject *)events {

    NSString *json = [self jsonStringFromObject:events];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[NSString stringWithFormat: @"Basic %@", self.authString] forHTTPHeaderField:@"Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        if ([data length] > 0 && error == nil)
            DSIOLog(@"Request successfully sent to %@.\nStatus code: %d.\nData Sent: %@.\n", urlRequest.URL, (int) responseCode, json);
        else if ([data length] == 0 && error == nil)
            DSIOLog(@"Please check network connection on the device and that the datasnap api keys have been entered correctly");
        else {
            DSIOLog(@"Error sending request to %@. Response code: %d.\n", urlRequest.URL, (int) responseCode);
            DSIOLog(json);
            if(error){
                DSIOLog(@"%@\n", error.description, json);
            }
        }
    }];
}

- (NSString *)jsonStringFromObject:(NSObject *)obj {
    return [self jsonStringFromObject:obj prettyPrint:NO];
}

- (NSString *)jsonStringFromObject:(NSObject *)obj prettyPrint:(BOOL)pretty {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:(NSJSONWritingOptions) (pretty ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    if (!jsonData) {
        DSIOLog(@"jsonStringFromObject: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}


@end
