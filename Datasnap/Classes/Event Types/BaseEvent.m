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
    objc_property_t* currentClassPropertyList = class_copyPropertyList([self class], &count);
    NSDictionary* currentClassPropertyValues = [self dictionaryFromProperties:currentClassPropertyList withCount:count];
    [dict addEntriesFromDictionary:currentClassPropertyValues];

    if ([NSStringFromClass([self superclass]) isEqualToString:@"BaseEvent"]) {
        unsigned superClassCount;
        objc_property_t* superClassPropertyList = class_copyPropertyList([self superclass], &superClassCount);
        NSDictionary* superClassPropertyValues = [self dictionaryFromProperties:superClassPropertyList withCount:superClassCount];
        [dict addEntriesFromDictionary:superClassPropertyValues];
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
                else if ([key isEqualToString:@"eventProperty"]) {
                    [dict setObject:[value dictionary] forKey:@"datasnap"];
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
