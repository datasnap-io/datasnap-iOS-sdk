//
//  User.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize tags;
@synthesize identifier;
@synthesize audience;
@synthesize userProperties;

- (void)initializeUser:(User*)user
{
    self.user = user;
}

- (User*)getInstance
{
    return self.user;
}

- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{ @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null],
        @"id" : [self.identifier convertToDictionary] ? [self.identifier convertToDictionary] : [NSNull null],
        @"audience" : self.audience ? self.audience : [NSNull null],
        @"user_properties" : [self.userProperties convertToDictionary] ? [self.userProperties convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
