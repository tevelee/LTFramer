//
//  NSDictionary+LTFramer.m
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "NSDictionary+LTFramer.h"

@implementation NSDictionary (LTFramer)

- (NSDictionary*)skyFramer_map:(id(^)(id<NSObject> key, id object))block
{
    if (block == nil) {
        return [self copy];
    }
    
    NSMutableDictionary* items = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    for (id key in self) {
        id item = self[key];
        id mapped = block(key, item);
        if (mapped) {
            items[key] = mapped;
        }
    }
    
    return [items copy];
}

- (NSDictionary*)skyFramer_filter:(BOOL(^)(id<NSObject> key, id object))block
{
    if (block == nil) {
        return [self copy];
    }
    
    NSMutableDictionary* items = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    for (id key in self) {
        id item = self[key];
        BOOL condition = block(key, item);
        if (condition) {
            items[key] = item;
        }
    }
    
    return [items copy];
}

@end
