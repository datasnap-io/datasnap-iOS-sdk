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
@property NSString* mobile_device_ios_idfa;
@property NSString* sha1_lowercase_email;
@property NSString* opt_in_location;

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
                        opt_in_location:(NSString*)optIn
                andSha1_lowercase_email:(NSString*)sha1Email;
@end
