//
//  User.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Audience.h"
#import "EventProperty.h"
#import "Identifier.h"
#import "Tags.h"
#import "UserProperties.h"

@interface User : EventProperty
@property Tags* tags;
@property Identifier* identifier;
@property Audience* audience;
@property UserProperties* userProperties;
- (User*)initWithIdentifier:(Identifier*)identifier;
- (NSDictionary*)convertToDictionary;
@end
