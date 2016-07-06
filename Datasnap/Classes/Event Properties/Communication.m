//
//  Communication.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Communication.h"

@implementation Communication
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"description" : self.description,
        @"identifier" : self.identifier,
        @"name" : self.title,
        @"types" : [self.types convertToDictionary] ? [self.types convertToDictionary] : [NSNull null],
        @"content" : [self.content convertToDictionary] ? [self.content convertToDictionary] : [NSNull null],
        @"status" : self.status ? self.status : [NSNull null],
        @"communication_vendor_id" : self.communicationVendorId ? self.communicationVendorId : [NSNull null],
        @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
- (Communication*)initWithDescription:(NSString*)description
                           identifier:(NSString*)identifier
                                title:(NSString*)title
                                types:(Types*)types
                              content:(Content*)content
                               status:(NSString*)status
                communicationVendorId:(NSString*)communicationVendorId
                              andTags:(Tags*)tags
{
    self.descriptionText = description;
    self.identifier = identifier;
    self.title = title;
    self.types = types;
    self.content = content;
    self.status = status;
    self.communicationVendorId = communicationVendorId;
    self.tags = tags;
    return self;
}
@end
