//
//  User.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "Identifier.h"

@interface User : EventProperty
@property Identifier* identifier;
- (User*)initWithIdentifier:(Identifier*)identifier;

@end
