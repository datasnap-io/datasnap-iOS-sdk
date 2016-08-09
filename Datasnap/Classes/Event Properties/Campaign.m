//
//  Campaign.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Campaign.h"

@implementation Campaign

- (Campaign*)initWithName:(NSString*)name
               identifier:(NSString*)identifier
         communicationIds:(NSString*)communicationIds
{
    self.name = name;
    self.identifier = identifier;
    self.communicationIds = communicationIds;
    return self;
}
@end
