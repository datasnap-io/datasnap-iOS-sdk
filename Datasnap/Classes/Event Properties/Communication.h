//
//  Communication.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"

@interface Communication : EventProperty
@property NSString* name;
@property NSString* identifier;
- (Communication*)initWithIdentifier:(NSString*)identifier
                                name:(NSString*)name;
@end
