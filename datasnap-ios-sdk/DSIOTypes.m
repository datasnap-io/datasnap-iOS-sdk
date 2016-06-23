//
//  DSIOTypes.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOTypes.h"

@implementation DSIOTypes
@synthesize id;
@synthesize name;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"id" : self.id ? self.id : [NSNull null],
        @"name" : self.name ? self.name : [NSNull null]
    };
    return dictionary;
}
@end
