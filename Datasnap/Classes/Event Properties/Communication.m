//
//  Communication.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Communication.h"

@implementation Communication

- (Communication*)initWithIdentifier:(NSString*)identifier
                                name:(NSString*)name
{
    self.identifier = identifier;
    self.name = name;
    return self;
}
@end
