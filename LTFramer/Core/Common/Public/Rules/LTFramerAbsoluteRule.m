//
//  LTFramerAbsoluteRule.m
//  Pods
//
//  Created by László Teveli on 2016. 10. 10..
//
//

#import "LTFramerAbsoluteRule.h"

@implementation LTFramerAbsoluteRule

+ (instancetype)absoluteRuleWithDelegate:(id<LTFramerAbsoluteRuleDelegate>)delegate
{
    LTFramerAbsoluteRule* rule = [LTFramerAbsoluteRule new];
    [rule setDelegate:delegate];
    return rule;
}

- (void)addRule:(LTFramerRule*)rule
{
    [self.delegate absoluteRuleDeclaration:self didGenerateNewRule:rule];
}

#pragma mark - Fluent API

- (id<LTFramer>)then
{
    return self.delegate;
}

- (id<LTFramerAbsoluteRule>)and
{
    return self;
}

- (id<LTFramerAbsoluteRule>)with
{
    return self;
}

- (id<LTFramerAbsoluteRule>)alignCenter
{
    return self.alignCenterX.and.alignCenterY;
}

- (id<LTFramerAbsoluteRule>)alignCenterX
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal position:LTFramerPositionAlignToCenter]];
    return self;
}

- (id<LTFramerAbsoluteRule>)alignCenterY
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical position:LTFramerPositionAlignToCenter]];
    return self;
}

- (id<LTFramerAbsoluteRule>)alignLeft
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal position:LTFramerPositionAlignToLeading]];
    return self;
}

- (id<LTFramerAbsoluteRule>)alignRight
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal position:LTFramerPositionAlignToTrailing]];
    return self;
}

- (id<LTFramerAbsoluteRule>)alignTop
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical position:LTFramerPositionAlignToLeading]];
    return self;
}

- (id<LTFramerAbsoluteRule>)alignBottom
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical position:LTFramerPositionAlignToTrailing]];
    return self;
}

- (id<LTFramerAbsoluteRule>)alignTopLeft
{
    return self.alignTop.and.alignLeft;
}

- (id<LTFramerAbsoluteRule>)alignTopRight
{
    return self.alignTop.and.alignRight;
}

- (id<LTFramerAbsoluteRule>)alignBottomLeft
{
    return self.alignBottom.and.alignLeft;
}

- (id<LTFramerAbsoluteRule>)alignBottomRight
{
    return self.alignBottom.and.alignRight;
}

- (id<LTFramerAbsoluteRule>)fitWidth
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal size:LTFramerSizeScaleToFit]];
    return self;
}

- (id<LTFramerAbsoluteRule>)fitHeight
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical size:LTFramerSizeScaleToFit]];
    return self;
}

- (id<LTFramerAbsoluteRule>)fillWidth
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal size:LTFramerSizeScaleToFill]];
    return self;
}

- (id<LTFramerAbsoluteRule>)fillHeight
{
    [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical size:LTFramerSizeScaleToFill]];
    return self;
}

- (id<LTFramerAbsoluteRule>(^)(double width))width
{
    return ^id<LTFramerAbsoluteRule>(double width){
        [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal exactSize:width]];
        return self;
    };
}

- (id<LTFramerAbsoluteRule>(^)(double height))height
{
    return ^id<LTFramerAbsoluteRule>(double height){
        [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical exactSize:height]];
        return self;
    };
}

- (id<LTFramerAbsoluteRule>(^)(CGSize size))size
{
    return ^id<LTFramerAbsoluteRule>(CGSize size){
        return self.width(size.width).and.height(size.height);
    };
}

- (id<LTFramerAbsoluteRule>(^)(double padding))left
{
    return ^id<LTFramerAbsoluteRule>(double padding){
        [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal padding:LTFramerPaddingLeading value:padding]];
        return self;
    };
}

- (id<LTFramerAbsoluteRule>(^)(double padding))right
{
    return ^id<LTFramerAbsoluteRule>(double padding){
        [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal padding:LTFramerPaddingTrailing value:padding]];
        return self;
    };
}

- (id<LTFramerAbsoluteRule>(^)(double padding))top
{
    return ^id<LTFramerAbsoluteRule>(double padding){
        [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical padding:LTFramerPaddingLeading value:padding]];
        return self;
    };
}

- (id<LTFramerAbsoluteRule>(^)(double padding))bottom
{
    return ^id<LTFramerAbsoluteRule>(double padding){
        [self addRule:[LTFramerRule ruleWithDirection:LTFramerDirectionVertical padding:LTFramerPaddingTrailing value:padding]];
        return self;
    };
}

- (id<LTFramerAbsoluteRule>(^)(double padding))bothSides
{
    return ^id<LTFramerAbsoluteRule>(double padding){
        return self.left(padding).and.right(padding);
    };
}

- (id<LTFramerAbsoluteRule>(^)(UIEdgeInsets paddings))paddings
{
    return ^id<LTFramerAbsoluteRule>(UIEdgeInsets paddings){
        return self.top(paddings.top).and.left(paddings.left).and.bottom(paddings.bottom).and.right(paddings.right);
    };
}

- (id<LTFramerAbsoluteRule>(^)(LTFramerRulePriority))priority
{
    return ^id<LTFramerAbsoluteRule>(LTFramerRulePriority priority){
        [self.delegate absoluteRuleDeclaration:self didModifyPriority:priority];
        return self;
    };
}

@end
