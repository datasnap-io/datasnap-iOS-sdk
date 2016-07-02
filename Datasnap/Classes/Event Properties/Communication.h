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
@property NSString* identifier;
@property NSString* title;
@property Types* types;
@property Content* content;
@property NSString* status;
@property NSString* communicationVendorId;
@property Tags* tags;
- (NSDictionary*)convertToDictionary;
- (Communication*)initWithCommunication:(Communication*)communication;

@end
