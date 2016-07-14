//
//  DictionaryWithObject.m
//  Pods
//
//  Created by Alyssa McIntyre on 7/14/16.
//
//

#import "NSObject+Helpers.h"

@implementation NSObject (Helpers)
- (NSDictionary*)dictionary
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];

    unsigned count;
    objc_property_t* properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString* key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:key];

        if ([value isKindOfClass:[NSNumber class]]
            || [value isKindOfClass:[NSString class]]
            || [value isKindOfClass:[NSDictionary class]]
            || [value isKindOfClass:[NSArray class]]) {
            [dict setObject:value forKey:key];
        }
        else if ([value isKindOfClass:[NSObject class]]) {
            [dict setObject:[value dictionary] forKey:key];
        }
        else {
            NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
        }
    }

    free(properties);

    return [NSDictionary dictionaryWithDictionary:dict];
}
@end
