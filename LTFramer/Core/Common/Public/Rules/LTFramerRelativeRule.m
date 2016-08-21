//
//  LTFramerRelativeRule.m
//  Pods
//
//  Created by László Teveli on 06/09/16.
//
//

#import "LTFramerRelativeRule.h"

@implementation LTFramerRelativeRule

+ (instancetype)relativeRuleWithDelegate:(id<LTFramerRelativeRuleDelegate>)delegate
{
    LTFramerRelativeRule* rule = [LTFramerRelativeRule new];
    [rule setDelegate:delegate];
    return rule;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.offsetValue = 0;
        self.multiplierValue = 1;
    }
    return self;
}

- (void)setProperty:(LTFramerSupportedProperty)property
{
    if (self.relation == LTFramerRelationNone) {
        [self setTargetProperty:property];
    } else {
        [self setSourceProperty:property];
    }
}

- (void)didModifyRule
{
    [self.delegate relativeRuleDeclarationDidModifyRule:self];
}

#pragma mark - Fluent API

- (id<LTFramer>)then
{
    return self.delegate;
}

- (id<LTFramerRelativeRule>)equalTo
{
    [self setRelation:LTFramerRelationEquality];
    return self;
}

- (id<LTFramerRelativeRule>)lessThan
{
    [self setRelation:LTFramerRelationLessThan];
    return self;
}

- (id<LTFramerRelativeRule>)lessThanOrEqualTo
{
    [self setRelation:LTFramerRelationLessThanOrEqual];
    return self;
}

- (id<LTFramerRelativeRule>)greaterThan
{
    [self setRelation:LTFramerRelationGreaterThan];
    return self;
}

- (id<LTFramerRelativeRule>)greaterThanOrEqualTo
{
    [self setRelation:LTFramerRelationGreaterThanOrEqual];
    return self;
}

- (id<LTFramerRelativeRule>)same
{
    [self setSourceProperty:self.targetProperty];
    return self;
}

- (id<LTFramerRelativeRule>(^)(LTFramerSubject subject))of
{
    return ^id<LTFramerRelativeRule>(LTFramerSubject subject){
        [self setSourceSubject:subject];
        [self didModifyRule];
        return self;
    };
}

- (id<LTFramerRelativeRule>)left
{
    [self setProperty:LTFramerSupportedPropertyLeadingX];
    return self;
}

- (id<LTFramerRelativeRule>)right
{
    [self setProperty:LTFramerSupportedPropertyTrailingX];
    return self;
}

- (id<LTFramerRelativeRule>)top
{
    [self setProperty:LTFramerSupportedPropertyLeadingY];
    return self;
}

- (id<LTFramerRelativeRule>)bottom
{
    [self setProperty:LTFramerSupportedPropertyTrailingY];
    return self;
}

- (id<LTFramerRelativeRule>)width
{
    [self setProperty:LTFramerSupportedPropertyWidth];
    return self;
}

- (id<LTFramerRelativeRule>)height
{
    [self setProperty:LTFramerSupportedPropertyHeight];
    return self;
}

- (id<LTFramerRelativeRule>)centerX
{
    [self setProperty:LTFramerSupportedPropertyCenterX];
    return self;
}

- (id<LTFramerRelativeRule>)centerY
{
    [self setProperty:LTFramerSupportedPropertyCenterY];
    return self;
}

- (id<LTFramerRelativeRule>(^)(double offset))offset
{
    return ^id<LTFramerRelativeRule>(double offset){
        [self setOffsetValue:offset];
        [self didModifyRule];
        return self;
    };
}

- (id<LTFramerRelativeRule>(^)(double multiplier))multiplier
{
    return ^id<LTFramerRelativeRule>(double multiplier){
        [self setMultiplierValue:multiplier];
        [self didModifyRule];
        return self;
    };
}

- (id<LTFramerRelativeRule>(^)(double value))value
{
    return ^id<LTFramerRelativeRule>(double value){
        [self setExactValue:@(value)];
        [self didModifyRule];
        return self;
    };
}

- (id<LTFramerRelativeRule>(^)(LTFramerRulePriority priority))priority
{
    return ^id<LTFramerRelativeRule>(LTFramerRulePriority priority){
        [self setPriorityValue:@(priority)];
        [self didModifyRule];
        return self;
    };
}

- (id<LTFramerRelativeRule>)with
{
    return self;
}

- (id<LTFramerRelativeRule>)and
{
    return self;
}

- (id<LTFramerRelativeRule>)the
{
    return self;
}

@end
