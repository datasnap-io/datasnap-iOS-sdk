//
//  User.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic identifier;
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
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{ @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null],
        @"id" : [self.identifier convertToDictionary] ? [self.identifier convertToDictionary] : [NSNull null],
        @"Audience" : self.audience ? self.audience : [NSNull null],
        @"user_properties" : [self.userProperties convertToDictionary] ? [self.userProperties convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
