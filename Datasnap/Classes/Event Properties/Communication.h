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
@property NSString* description;
@property NSString* title;
@property Types* types;
@property Content* content;
@property NSString* status;
@property NSString* communicationVendorId;
@property Tags* tags;
- (NSDictionary*)convertToDictionary;
- (Communication*)initWithDescription:(NSString*)description
                           identifier:(NSString*)identifier
                                title:(NSString*)title
                                types:(Types*)types
                              content:(Content*)content
                               status:(NSString*)status
                communicationVendorId:(NSString*)communicationVendorId
                              andTags:(Tags*)tags;
@end
