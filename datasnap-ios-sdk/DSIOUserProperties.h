//
//  DSIOUserProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEventProperty.h"

@interface DSIOUserProperties : DSIOEventProperty
@property NSString* userType;
@property NSString* high;
@property NSString* engagementTime;
- (NSDictionary*)convertToDictionary;
@end
