//
//  Communication.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "Content.h"
#import "EventProperty.h"
#import "Tags.h"
#import "Types.h"
#import <Foundation/Foundation.h>

@interface Communication : EventProperty
@property NSString* descriptionText;
@property NSString* name;
@property Types* types;
@property Content* content;
@property NSString* status;
@property NSString* communicationVendorId;
@property Tags* tags;
@property NSString* identifier;
- (Communication*)initWithDescription:(NSString*)description
                           identifier:(NSString*)identifier
                                 name:(NSString*)name
                                types:(Types*)types
                              content:(Content*)content
                               status:(NSString*)status
                communicationVendorId:(NSString*)communicationVendorId
                              andTags:(Tags*)tags;
@end
