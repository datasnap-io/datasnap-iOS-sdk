//
//  SDKErrorEvent.m
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//

#import "SDKErrorEvent.h"

@implementation SDKErrorEvent
- (SDKErrorEvent*)initWithErrorMessage:(NSString*)errorMessage
{
    self.error_msg = errorMessage;
    self.event_type = @"sdk_error";
    return self;
}
@end
