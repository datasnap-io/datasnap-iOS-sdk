//
//  DSIOAudience.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEventProperty.h"

@interface DSIOAudience : DSIOEventProperty
@property NSString* education;
@property NSString* college;
@property NSString* age;
@property NSString* ethnicity;
@property NSString* kids;
@property NSString* gender;
@property NSString* interests;
@property NSString* income;
- (NSDictionary*)convertToDictionary;
@end
