//
//  Campaign.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "EventProperty.h"
#import <Foundation/Foundation.h>

@interface Campaign : EventProperty
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* communicationIds;
@property NSString* identifier;
- (Campaign*)initWithName:(NSString*)name
               identifier:(NSString*)identifier
         communicationIds:(NSString*)communicationIds;
@end
