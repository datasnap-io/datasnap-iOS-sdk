//
//  Communication.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Communication.h"

@implementation Communication

- (Communication*)initWithDescription:(NSString*)description
                           identifier:(NSString*)identifier
                                 name:(NSString*)name
                                types:(Types*)types
                              content:(Content*)content
                               status:(NSString*)status
                communicationVendorId:(NSString*)communicationVendorId
                              andTags:(Tags*)tags
{
    self.descriptionText = description;
    self.identifier = identifier;
    self.name = name;
    self.types = types;
    self.content = content;
    self.status = status;
    self.communicationVendorId = communicationVendorId;
    self.tags = tags;
    return self;
}
@end
