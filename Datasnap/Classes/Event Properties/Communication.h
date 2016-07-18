//
//  Communication.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

@interface Communication
@property NSString* name;
@property NSString* identifier;
- (Communication*)initWithIdentifier:(NSString*)identifier
                                 name:(NSString*)name;
@end
