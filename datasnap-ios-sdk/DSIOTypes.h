//
//  DSIOTypes.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEventProperty.h"

@interface DSIOTypes : DSIOEventProperty
@property NSString* id;
@property NSString* name;
- (NSDictionary*)convertToDictionary;
@end
