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
    NSDictionary* ownProperties = [self dictionaryFromProperties:properties withCount:count];
    [dict addEntriesFromDictionary:ownProperties];

    if ([NSStringFromClass([self superclass]) isEqualToString:@"BaseEvent"]) {
        objc_property_t* baseEventProperties;
        unsigned baseEventCount;
        baseEventProperties = class_copyPropertyList([self superclass], &baseEventCount);
        NSDictionary* baseEventDict = [self dictionaryFromProperties:baseEventProperties withCount:baseEventCount];
        [dict addEntriesFromDictionary:baseEventDict];
    }

    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSDictionary*)dictionaryFromProperties:(objc_property_t*)properties withCount:(unsigned)count
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
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
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (BaseEvent*)initWithEventType:(NSString*)eventType
{
    self.event_type = eventType;
    return self;
}
@end
