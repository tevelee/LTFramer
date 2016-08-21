//
//  LTFramerProperty.m
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerSizeProperty.h"

@implementation LTFramerSizeProperty

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConstraint:LTFramerConstraintSize];
    }
    return self;
}

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction size:(LTFramerSize)size
{
    LTFramerSizeProperty* property = [self propertyWithDirection:direction];
    [property setSize:size];
    return property;
}

- (BOOL)isEqualToProperty:(LTFramerSizeProperty *)property
{
    BOOL isEqualToSuperRule = [super isEqualToProperty:property];
    if (isEqualToSuperRule == NO) {
        return NO;
    }
    
    BOOL haveEqualRules = self.size == property.size;
    
    return haveEqualRules;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    LTFramerSizeProperty* copy = [super copyWithZone:zone];
    
    [copy setSize:self.size];
    
    return copy;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    NSUInteger superHash = [super hash];
    return superHash ^ [@(self.size) hash];
}

@end
