//
//  UserProperties.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "UserProperties.h"

@implementation UserProperties
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{ @"user_type" : self.userType ? self.userType : [NSNull null],
        @"high" : self.high ? self.high : [NSNull null],
        @"engagement_type" : self.engagementTime ? self.engagementTime : [NSNull null]
    };
    return dictionary;
}
@end
