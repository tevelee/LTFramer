//
//  LTFramerProperty.m
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerPaddingProperty.h"

@implementation LTFramerPaddingProperty

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConstraint:LTFramerConstraintPadding];
    }
    return self;
}

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction padding:(LTFramerPadding)padding
{
    LTFramerPaddingProperty* property = [self propertyWithDirection:direction];
    [property setPadding:padding];
    return property;
}

- (BOOL)isEqualToProperty:(LTFramerPaddingProperty *)property
{
    BOOL isEqualToSuperRule = [super isEqualToProperty:property];
    if (isEqualToSuperRule == NO) {
        return NO;
    }
    
    BOOL haveEqualRules = self.padding == property.padding;
    
    return haveEqualRules;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    LTFramerPaddingProperty* copy = [super copyWithZone:zone];
    
    [copy setPadding:self.padding];
    
    return copy;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    NSUInteger superHash = [super hash];
    return superHash ^ [@(self.padding) hash];
}

@end
