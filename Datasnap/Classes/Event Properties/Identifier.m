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
                        opt_in_location:(NSString*)optIn
                andSha1_lowercase_email:(NSString*)sha1Email
{
    self.global_Distinct_id = global_distinct_id;
    self.opt_in_location = optIn;
    if ([optIn isEqualToString:@"YES"]) {
        self.mobile_device_ios_idfa = [self identifierForAdvertising];
    }
    self.sha1_lowercase_email = sha1Email;
    return self;
}

- (NSString*)identifierForAdvertising
{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSUUID* IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        return [IDFA UUIDString];
    }
    return nil;
}

@end
