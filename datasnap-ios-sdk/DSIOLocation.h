//
//  DSIOLocation.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEventProperty.h"

@interface DSIOLocation : DSIOEventProperty
@property NSArray* coordinates;
- (NSDictionary*)convertToDictionary;
@end
