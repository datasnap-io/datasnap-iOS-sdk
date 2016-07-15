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
                              content:(Content*)content
                               status:(NSString*)status
                communicationVendorId:(NSString*)communicationVendorId
{
    self.descriptionText = description;
    self.identifier = identifier;
    self.name = name;
    self.content = content;
    self.status = status;
    self.communicationVendorId = communicationVendorId;
    return self;
}
@end
