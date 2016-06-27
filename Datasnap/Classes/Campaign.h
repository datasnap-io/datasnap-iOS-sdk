//
//  Campaign.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import "Tags.h"
#import <Foundation/Foundation.h>

@interface Campaign : EventProperty
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* identifier;
@property (nonatomic) NSString* communicationIds;
@property Tags* tags;
- (NSDictionary*)convertToDictionary;
@end
