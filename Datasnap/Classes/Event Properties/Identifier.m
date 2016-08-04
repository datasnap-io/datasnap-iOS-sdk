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
{
    self.global_distinct_id = global_distinct_id;
    self.sha1_lowercase_email = sha1Email;
    return self;
}
@end
