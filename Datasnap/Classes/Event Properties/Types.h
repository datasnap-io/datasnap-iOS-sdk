//
//  Types.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface Types : EventProperty
@property NSString* identifier;
@property NSString* name;
- (NSDictionary*)convertToDictionary;
@end
