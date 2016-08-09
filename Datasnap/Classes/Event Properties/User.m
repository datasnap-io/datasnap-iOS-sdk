//
//  User.m
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//

#import "User.h"

@implementation User
- (User*)initWithIdentifier:(Identifier*)identifier
{
    self.identifier = identifier;
    return self;
}
@end