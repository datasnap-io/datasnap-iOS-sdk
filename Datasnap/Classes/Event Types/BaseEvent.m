//
//  Event.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import <objc/runtime.h>
@implementation BaseEvent
- (NSDictionary*)dictionary
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t* properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString* key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:key];
        if (value) {
            if ([value isKindOfClass:[NSNumber class]]
                || [value isKindOfClass:[NSString class]]
                || [value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]]) {
                [dict setObject:value forKey:key];
            }
            else if ([value isKindOfClass:[NSObject class]]) {
                if ([key isEqualToString:@"identifier"]) {
                    [dict setObject:[value dictionary] forKey:@"id"];
                }
                else if ([key isEqualToString:@"globalPosition"]) {
                    [dict setObject:[value dictionary] forKey:@"global-position"];
                }
                else {
                    [dict setObject:[value dictionary] forKey:key];
                }
            }
            else {
                NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
            }
        }
    }
    free(properties);
    if ([NSStringFromClass([self superclass]) isEqualToString: @"BaseEvent"]) {
        [[self superclass] performSelector:@selector(dictionary)];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (BaseEvent*)initWithEventType:(NSString*)eventType
{
    self.event_type = eventType;
    return self;
}
@end
