//
//  User.h
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//

#import "EventProperty.h"
#import "Identifier.h"
@interface User : EventProperty
@property Identifier* identifier;
- (User*)initWithIdentifier:(Identifier*)identifier;
@end
