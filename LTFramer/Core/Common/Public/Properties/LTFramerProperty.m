//
//  LTFramerProperty.m
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerProperty.h"

@implementation LTFramerProperty

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction
{
    LTFramerProperty* property = [self new];
    [property setDirection:direction];
    return property;
}

- (BOOL)isEqualToProperty:(LTFramerProperty *)property
{
    if (property == nil) {
        return NO;
    }
    
    BOOL haveEqualDirections = self.direction == property.direction;
    BOOL haveEqualConstrains = self.constraint == property.constraint;
    
    return haveEqualDirections && haveEqualConstrains;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    LTFramerProperty* copy = [[[self class] allocWithZone:zone] init];
    
    [copy setDirection:self.direction];
    [copy setConstraint:self.constraint];
    
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
    
    return [self isEqualToProperty:object];
}

- (NSUInteger)hash
{
    return [@(self.direction) hash] ^ [@(self.constraint) hash];
}

@end
