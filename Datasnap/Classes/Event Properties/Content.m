//
//  Content.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Content.h"

@implementation Content
@synthesize text;
@synthesize description;
@synthesize image;
@synthesize html;
@synthesize url;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"text" : self.text ? self.text : [NSNull null],
        @"description" : self.description ? self.description : [NSNull null],
        @"image" : self.image ? self.image : [NSNull null],
        @"html" : self.html ? self.html : [NSNull null],
        @"url" : self.url ? self.url : [NSNull null]
    };
    return dictionary;
}
@end
