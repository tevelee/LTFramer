//
//  NSArray+LTFramer.m
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import "NSArray+LTFramer.h"

@implementation NSArray (LTFramerFunctional)

- (NSArray*)skyFramer_map:(id(^)(id object))block
{
    if (block == nil) {
        return [self copy];
    }
    
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id item in self) {
        id mapped = block(item);
        if (mapped) {
            [items addObject:item];
        }
    }
    
    return [items copy];
}

- (NSArray*)skyFramer_filter:(BOOL(^)(id object))block
{
    if (block == nil) {
        return [self copy];
    }
    
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id item in self) {
        BOOL condition = block(item);
        if (condition) {
            [items addObject:item];
        }
    }
    
    return [items copy];
}

- (NSArray*)skyFramer_while:(BOOL(^)(id object))block
{
    if (block == nil) {
        return [self copy];
    }
    
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id item in self) {
        BOOL condition = block(item);
        if (condition) {
            [items addObject:item];
        } else {
            break;
        }
    }
    
    return [items copy];
}

- (NSArray*)skyFramer_until:(BOOL(^)(id object))block
{
    if (block == nil) {
        return [self copy];
    }
    
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id item in self) {
        BOOL condition = block(item);
        if (condition) {
            break;
        } else {
            [items addObject:item];
        }
    }
    
    return [items copy];
}

- (NSDictionary*)skyFramer_dictionaryUsingKey:(id<NSCopying>(^)(id object))block
{
    if (block == nil) {
        return @{};
    }
    
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    for (id item in self) {
        id<NSCopying> key = block(item);
        if (key) {
            result[key] = item;
        }
    }
    
    return [result copy];
}

- (id)skyFramer_aggregateWithInitial:(id)initial block:(id(^)(id rolling, id current))block
{
    if (block == nil) {
        return nil;
    }
    
    id value = nil;
    for (id item in self) {
        value = block(value, item);
    }
    return value;
}

- (double)skyFramer_sum:(double(^)(id object))block
{
    return [[self skyFramer_aggregateWithInitial:@0 block:^NSNumber*(NSNumber* rolling, id object) {
        return @(rolling.doubleValue + block(object));
    }] doubleValue];
}

- (double)skyFramer_max:(double(^)(id object))block
{
    return [[self skyFramer_aggregateWithInitial:nil block:^NSNumber*(NSNumber* rolling, id object) {
        double item = block(object);
        if (item) {
            return @(MAX(rolling.doubleValue, item));
        } else {
            return rolling;
        }
    }] doubleValue];
}

- (double)skyFramer_min:(double(^)(id object))block
{
    return [[self skyFramer_aggregateWithInitial:nil block:^NSNumber*(NSNumber* rolling, id object) {
        double item = block(object);
        if (item) {
            return @(MIN(rolling.doubleValue, item));
        } else {
            return rolling;
        }
    }] doubleValue];
}

- (BOOL)skyFramer_if:(BOOL(^)(id object))block
{
    if (block == nil) {
        return NO;
    }
    
    for (id item in self) {
        BOOL condition = block(item);
        if (condition) {
            return YES;
        }
    }
    
    return NO;
}

- (id)skyFramer_first:(BOOL(^)(id object))block
{
    if (block == nil) {
        return nil;
    }
    
    for (id item in self) {
        BOOL condition = block(item);
        if (condition) {
            return item;
        }
    }
    
    return nil;
}

- (void)skyFramer_forEach:(void(^)(id object))block
{
    if (block == nil) {
        return;
    }
    
    for (id item in self) {
        block(item);
    }
}

@end
