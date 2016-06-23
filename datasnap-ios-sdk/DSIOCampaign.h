//
//  DSIOCampaign.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOEventProperty.h"
#import "DSIOTags.h"
#import <Foundation/Foundation.h>

@interface DSIOCampaign : DSIOEventProperty
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* identifier;
@property (nonatomic) NSString* communicationIds;
@property DSIOTags* tags;
- (NSDictionary*)convertToDictionary;
@end
