//
//  UserProperties.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "UserProperties.h"

@implementation UserProperties

- (UserProperties*)initWithUserType:(NSString*)userType
                               high:(NSString*)high
                  andEngagementType:(NSString*)engagementType
{
    self.userType = userType;
    self.high = high;
    self.engagementTime = engagementType;
    return self;
}
@end
