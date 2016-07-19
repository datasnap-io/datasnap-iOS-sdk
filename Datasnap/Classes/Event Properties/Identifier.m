//
//  Identifier.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Identifier.h"

@implementation Identifier

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinct_id
                andSha1_lowercase_email:(NSString*)sha1Email
                                andIDFA:(NSString*)mobile_device_ios_idfa
{
    self.global_distinct_id = global_distinct_id;
    self.mobile_device_ios_idfa = mobile_device_ios_idfa;
    self.sha1_lowercase_email = sha1Email;
    return self;
}
- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
{
    self.global_distinct_id = global_distinctId;
    return self;
}

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
                andSha1_lowercase_email:(NSString*)sha1Email
{
    self.global_distinct_id = global_distinctId;
    self.sha1_lowercase_email = sha1Email;
    return self;
}

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
                                andIDFA:(NSString*)mobile_device_ios_idfa
{
    self.global_distinct_id = global_distinctId;
    self.mobile_device_ios_idfa = mobile_device_ios_idfa;
    return self;
}
@end
