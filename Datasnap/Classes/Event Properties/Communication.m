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
