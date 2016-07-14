//
//  EventProperty.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventProperty : NSObject
@property NSString* identifier;
- (EventProperty*)initWithIdentifier:(NSString*)identifier;

@end
