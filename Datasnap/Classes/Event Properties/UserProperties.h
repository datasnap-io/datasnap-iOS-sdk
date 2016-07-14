//
//  UserProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface UserProperties : EventProperty
@property NSString* userType;
@property NSString* high;
@property NSString* engagementTime;

- (UserProperties*)initWithUserType:(NSString*)userType
                               high:(NSString*)high
                  andEngagementType:(NSString*)engagementType;
@end
