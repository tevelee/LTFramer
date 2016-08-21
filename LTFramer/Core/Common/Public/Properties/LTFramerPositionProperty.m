//
//  LTFramerProperty.m
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerPositionProperty.h"

@implementation LTFramerPositionProperty

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConstraint:LTFramerConstraintPosition];
    }
    return self;
}

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction position:(LTFramerPosition)position
{
    LTFramerPositionProperty* property = [self propertyWithDirection:direction];
    [property setPosition:position];
    return property;
}

- (BOOL)isEqualToProperty:(LTFramerPositionProperty *)property
{
    BOOL isEqualToSuperRule = [super isEqualToProperty:property];
    if (isEqualToSuperRule == NO) {
        return NO;
    }
    
    BOOL haveEqualRules = self.position == property.position;
    
    return haveEqualRules;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    LTFramerPositionProperty* copy = [super copyWithZone:zone];
    
    [copy setPosition:self.position];
    
    return copy;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    NSUInteger superHash = [super hash];
    return superHash ^ [@(self.position) hash];
}

@end
