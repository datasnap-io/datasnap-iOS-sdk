//
//  DSIOLocation.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOLocation.h"

@implementation DSIOLocation
@synthesize coordinates;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"coordinates" : self.coordinates ? self.coordinates : [NSNull null]
    };
    return dictionary;
}
@end
