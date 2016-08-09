//
//  EventProperty.h
//  Pods
//
//  Created by Alyssa McIntyre on 7/19/16.
//
//
#import <objc/runtime.h>
@class Device;
@interface EventProperty : NSObject
@property NSString* created;
@property Device* device;
- (EventProperty*)initWithDate:(NSString*)created
                     andDevice:(Device*)device;
- (NSDictionary*)dictionary;
@end
