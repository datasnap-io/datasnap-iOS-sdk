//
//  Content.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "EventProperty.h"

@interface Content : EventProperty
@property NSString* text;
@property NSString* image;
@property NSString* html;
@property NSString* url;

- (Content*)initWithText:(NSString*)text
                   image:(NSString*)image
                    html:(NSString*)html
                  andUrl:(NSString*)url;
@end
