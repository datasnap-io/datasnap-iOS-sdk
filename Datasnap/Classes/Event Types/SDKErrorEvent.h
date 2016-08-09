//
//  SDKErrorEvent.h
//  Pods
//
//  Created by Alyssa McIntyre on 7/25/16.
//
//
#import "BaseEvent.h"
@interface SDKErrorEvent : BaseEvent
@property NSString* error_msg;
- (SDKErrorEvent*)initWithErrorMessage:(NSString*)errorMessage;
@end
