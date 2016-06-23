//
//  DSIOCommunication.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOContent.h"
#import "DSIOEventProperty.h"
#import "DSIOTags.h"
#import "DSIOTypes.h"
#import <Foundation/Foundation.h>

@interface DSIOCommunication : DSIOEventProperty
@property NSString* description;
@property NSString* identifier;
@property NSString* title;
@property DSIOTypes* types;
@property DSIOContent* content;
@property NSString* status;
@property NSString* communicationVendorId;
@property DSIOTags* tags;
- (NSDictionary*)convertToDictionary;
@end
