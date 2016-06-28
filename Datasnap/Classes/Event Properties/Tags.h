//
//  Tags.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface Tags : EventProperty
@property NSArray* tags;
- (NSDictionary*)convertToDictionary;
@end
