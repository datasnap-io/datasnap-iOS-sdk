//
//  Location.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize coordinates;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"coordinates" : self.coordinates ? self.coordinates : [NSNull null]
    };
    return dictionary;
}
@end
