//
//  User.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "User.h"

@implementation User
- (User*)initWithIdentifier:(Identifier*)identifier
                       tags:(Tags*)tags
                   audience:(Audience*)audience
          andUserProperties:(UserProperties*)userProperties
{
    self.identifier = identifier;
    self.tags = tags;
    self.audience = audience;
    self.userProperties = userProperties;
    return self;
}

@end
