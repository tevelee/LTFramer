//
//  LTFramerRule.m
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import "LTFramerRule.h"

@implementation LTFramerRule

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction position:(LTFramerPosition)position
{
    LTFramerRule* rule = [LTFramerRule new];
    [rule setProperty:[LTFramerPositionProperty propertyWithDirection:direction position:position]];
    return rule;
}

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction exactPosition:(double)position
{
    LTFramerRule* rule = [LTFramerRule new];
    [rule setProperty:[LTFramerPositionProperty propertyWithDirection:direction]];
    [rule setValue:@(position)];
    return rule;
}

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction size:(LTFramerSize)size
{
    LTFramerRule* rule = [LTFramerRule new];
    [rule setProperty:[LTFramerSizeProperty propertyWithDirection:direction size:size]];
    return rule;
}

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction exactSize:(double)size
{
    LTFramerRule* rule = [LTFramerRule new];
    [rule setProperty:[LTFramerSizeProperty propertyWithDirection:direction]];
    [rule setValue:@(size)];
    return rule;
}

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction padding:(LTFramerPadding)padding value:(double)value
{
    LTFramerRule* rule = [LTFramerRule new];
    [rule setProperty:[LTFramerPaddingProperty propertyWithDirection:direction padding:padding]];
    [rule setValue:@(value)];
    return rule;
}

- (BOOL)isEqualToRule:(LTFramerRule *)rule
{
    if (rule == nil) {
        return NO;
    }
    
    BOOL haveEqualProperties = [self.property isEqual:rule.property];
    BOOL haveEqualValues = (self.value == nil && rule.value == nil) || [self.value isEqual:rule.value];
    BOOL haveEqualPriorities = (self.priority == nil && rule.priority == nil) || [self.priority isEqual:rule.priority];
    
    return haveEqualProperties && haveEqualValues && haveEqualPriorities;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    LTFramerRule* copy = [[[self class] allocWithZone:zone] init];
    
    [copy setValue:self.value.copy];
    [copy setProperty:self.property.copy];
    
    return copy;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if ([object isKindOfClass:[self class]] == NO) {
        return NO;
    }
    
    return [self isEqualToRule:object];
}

- (NSUInteger)hash
{
    return [self.property hash] ^ [self.value hash];
}

@end
