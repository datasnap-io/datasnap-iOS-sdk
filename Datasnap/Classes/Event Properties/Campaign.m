//
//  Campaign.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Campaign.h"

@implementation Campaign

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
