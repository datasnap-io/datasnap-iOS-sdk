//
//  Campaign.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Campaign.h"

@implementation Campaign
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"name" : self.title ? self.title : [NSNull null],
        @"identifier" : self.identifier,
        @"communication_ids" : self.communicationIds,
        @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
- (Campaign*)initWithTitle:(NSString*)title
                identifier:(NSString*)identifier
          communicationIds:(NSString*)communicationIds
                   andTags:(Tags*)tags
{
    self.title = title;
    self.identifier = identifier;
    self.communicationIds = communicationIds;
    self.tags = tags;
    return self;
}
@end
