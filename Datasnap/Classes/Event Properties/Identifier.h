//
//  Identifier.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import <AdSupport/ASIdentifierManager.h>

@interface Identifier : EventProperty
@property NSString* global_distinct_id;
@property NSString* mobile_device_ios_idfa;
@property NSString* sha1_lowercase_email;

/*
	All of these are Not static. We need to grab them when
	we generate the event. These can change over time.
*/

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId;

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
                andSha1_lowercase_email:(NSString*)sha1Email;

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
                andIDFA:(NSString*)mobile_device_ios_idfa;

- (Identifier*)initWithGlobalDistinctId:(NSString*)global_distinctId
				andSha1_lowercase_email:(NSString*)sha1Email
                andIDFA:(NSString*)mobile_device_ios_idfa;

@end
