//
//  Tags.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Tags.h"

@implementation Tags
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"tags" : self.tags ? self.tags : [NSNull null]
    };
    return dictionary;
}
@end
