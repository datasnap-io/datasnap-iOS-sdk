//
//  DefaultProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

/*
	These are client-level configurations.
	These are NOT event properties. This interface needs to
	move out of the Event Properties Directory
*/

@interface DefaultProperties : NSObject
@property NSInteger* timeout;
@property NSInteger* retries;
@property NSInteger* backoff;
@property NSInteger* batchIncrement;
@end
