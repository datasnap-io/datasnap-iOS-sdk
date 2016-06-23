//
//  DSIOUser.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOUser.h"

@implementation DSIOUser
@synthesize tags;
@synthesize identifier;
@synthesize DSIOAudience;
@synthesize userProperties;

- (void)initializeUser:(DSIOUser*)user
{
    self.user = user;
}

- (DSIOUser*)getInstance
{
    return self.user;
}

- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{ @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null],
        @"id" : [self.identifier convertToDictionary] ? [self.identifier convertToDictionary] : [NSNull null],
        @"DSIOAudience" : self.DSIOAudience ? self.DSIOAudience : [NSNull null],
        @"user_properties" : [self.userProperties convertToDictionary] ? [self.userProperties convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
