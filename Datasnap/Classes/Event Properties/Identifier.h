//
//  Identifier.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import <AdSupport/ASIdentifierManager.h>

@interface Identifier : EventProperty
@property NSString* global_distinct_id;
@property NSString* sha1_lowercase_email;

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
                andSha1_lowercase_email:(NSString*)sha1Email;
@end
