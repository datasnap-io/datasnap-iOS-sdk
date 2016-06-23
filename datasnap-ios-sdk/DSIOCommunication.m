//
//  DSIOCommunication.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOCommunication.h"

@implementation DSIOCommunication
@synthesize description;
@synthesize identifier;
@synthesize title;
@synthesize types;
@synthesize content;
@synthesize status;
@synthesize communicationVendorId;
@synthesize tags;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"description" : self.description,
        @"id" : self.identifier,
        @"title" : self.title,
        @"types" : [self.types convertToDictionary] ? [self.types convertToDictionary] : [NSNull null],
        @"content" : [self.content convertToDictionary] ? [self.content convertToDictionary] : [NSNull null],
        @"status" : self.status ? self.status : [NSNull null],
        @"communication_vendor_id" : self.communicationVendorId,
        @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
@end
