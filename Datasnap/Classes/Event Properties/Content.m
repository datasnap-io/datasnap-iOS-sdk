//
//  Content.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Content.h"

@implementation Content

- (Content*)initWithText:(NSString*)text
                   image:(NSString*)image
                    html:(NSString*)html
                  andUrl:(NSString*)url
{
    self.text = text;
    self.image = image;
    self.html = html;
    self.url = url;
    return self;
}
@end
