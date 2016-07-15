//
//  Communication.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Content.h"
#import "EventProperty.h"
#import <Foundation/Foundation.h>

@interface Communication : EventProperty
@property NSString* descriptionText;
@property NSString* name;
@property Content* content;
@property NSString* status;
@property NSString* communicationVendorId;
@property NSString* identifier;
- (Communication*)initWithDescription:(NSString*)description
                           identifier:(NSString*)identifier
                                 name:(NSString*)name
                              content:(Content*)content
                               status:(NSString*)status
                communicationVendorId:(NSString*)communicationVendorId;
@end
