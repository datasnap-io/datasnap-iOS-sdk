//
//  DSIODefaultProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "DSIOEventProperty.h"

@interface DSIODefaultProperties : DSIOEventProperty
@property NSInteger* maxQueueSize;
@property NSInteger* timeout;
@property NSInteger* retries;
@property NSInteger* backoff;
@property NSInteger* batchIncrement;
@end
