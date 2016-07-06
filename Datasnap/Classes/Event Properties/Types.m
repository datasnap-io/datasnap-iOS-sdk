//
//  Types.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Types.h"

@implementation Types
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"id" : self.identifier ? self.identifier : [NSNull null],
        @"name" : self.name ? self.name : [NSNull null]
    };
    return dictionary;
}
- (Types*)initWithName:(NSString*)name
{
    self.name = name;
    return self;
}
@end
