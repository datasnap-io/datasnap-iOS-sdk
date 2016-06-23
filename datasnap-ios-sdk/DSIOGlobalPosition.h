//
//  DSIOGlobalPosition.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOEventProperty.h"
#import "DSIOLocation.h"

@interface DSIOGlobalPosition : DSIOEventProperty
@property DSIOLocation* location;
@property NSString* altitude;
@property NSString* accuracy;
@property NSString* course;
@property NSString* speed;
- (NSDictionary*)convertToDictionary;
@end
