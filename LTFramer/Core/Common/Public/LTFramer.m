//
//  LTFramer.m
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import "LTFramer.h"
#import "NSArray+LTFramer.h"
#import "UIView+LTFramer.h"
#import "LTFramerAbsoluteRule.h"
#import "LTFramerRelativeRule.h"
#import "LTFramerConfiguration.h"

@interface LTFramer () <LTFramerAbsoluteRuleDelegate, LTFramerRelativeRuleDelegate>

@property (nonatomic, strong) NSMutableArray* rules;
@property (nonatomic, strong) NSValue* cachedRect;
@property (nonatomic, assign) CGSize boundingSize;
@property (nonatomic, strong) LTFramerSubject subject;
@property (nonatomic, strong) NSMutableArray* rulesInScope;

@end

@implementation LTFramer

+ (instancetype)framerWithSubject:(LTFramerSubject)subject boundingSize:(CGSize)boundingSize
{
    return [[self alloc] initWithSubject:subject boundingSize:boundingSize];
}

- (instancetype)initWithSubject:(LTFramerSubject)subject boundingSize:(CGSize)boundingSize
{
    self = [super init];
    if (self) {
        [self setSubject:subject];
        [self setBoundingSize:boundingSize];
        [self resetRules];
    }
    return self;
}

- (void)setFrameInRelativeContainer:(CGRect)container
{
    CGRect frame = [self computedFrameInRelativeContainer:container];
    [self.subject setFrame:frame];
}

- (void)setFrameIgnoringTransformInRelativeContainer:(CGRect)container
{
    BOOL subjectIsView = [self.subject isKindOfClass:[UIView class]];
    BOOL subjectIsLayer = [self.subject isKindOfClass:[CALayer class]];
    NSAssert(subjectIsView || subjectIsLayer, @"Setting frames without transform is only supported on transform-compatible UIViews and CALayers");
    
    CGRect frame = [self computedFrameInRelativeContainer:container];
    
    if (subjectIsView) {
        UIView* view = (UIView*)self.subject;
        CGAffineTransform originalTransform = view.transform;
        [view setTransform:CGAffineTransformIdentity];
        [view setFrame:frame];
        [view setTransform:originalTransform];
    } else if (subjectIsLayer) {
        CALayer* layer = (CALayer*)self.subject;
        CATransform3D originalTransform = layer.transform;
        [layer setTransform:CATransform3DIdentity];
        [layer setFrame:frame];
        [layer setTransform:originalTransform];
    } else {
        [self.subject setFrame:frame];
    }
}

- (CGRect)computedFrameInRelativeContainer:(CGRect)container
{
    [self addMissingRulesIfNeeded];
    return [self evaluateRulesInRelativeContainer:container];
}

- (CGRect)defaultContainer
{
    return (CGRect){CGPointZero, self.boundingSize};
}

- (void)setFrame
{
    [self setFrameInRelativeContainer:self.defaultContainer];
}

- (void)setFrameIgnoringTransform
{
    [self setFrameIgnoringTransformInRelativeContainer:self.defaultContainer];
}

- (CGRect)computedFrame
{
    return [self computedFrameInRelativeContainer:self.defaultContainer];
}

- (void)addMissingRulesIfNeeded
{
    BOOL haveHorizontalPositioningRule = [self.rules skyFramer_if:^BOOL(LTFramerRule* rule) {
        return rule.property.constraint == LTFramerConstraintPosition && rule.property.direction == LTFramerDirectionHorizontal;
    }];
    if (haveHorizontalPositioningRule == NO)
    {
        [self.rules addObject:[self defaultHorizontalPositioningRule]];
    }
    
    BOOL haveVerticalPositioningRule = [self.rules skyFramer_if:^BOOL(LTFramerRule* rule) {
        return rule.property.constraint == LTFramerConstraintPosition && rule.property.direction == LTFramerDirectionVertical;
    }];
    if (haveVerticalPositioningRule == NO)
    {
        [self.rules addObject:[self defaultVerticalPositioningRule]];
    }
    
    BOOL haveHorizontalSizingRule = [self.rules skyFramer_if:^BOOL(LTFramerRule* rule) {
        return rule.property.constraint == LTFramerConstraintSize && rule.property.direction == LTFramerDirectionHorizontal;
    }];
    if (haveHorizontalSizingRule == NO)
    {
        [self.rules addObject:[self defaultHorizontalSizingRule]];
    }
    
    BOOL haveVerticalSizingRule = [self.rules skyFramer_if:^BOOL(LTFramerRule* rule) {
        return rule.property.constraint == LTFramerConstraintSize && rule.property.direction == LTFramerDirectionVertical;
    }];
    if (haveVerticalSizingRule == NO)
    {
        [self.rules addObject:[self defaultVerticalSizingRule]];
    }
}

- (CGRect)evaluateRulesInRelativeContainer:(CGRect)container
{
    if (self.cachedRect == nil) {
        double x = [self computeLeadingPositionForDirection:LTFramerDirectionHorizontal relativeContainer:container];
        double y = [self computeLeadingPositionForDirection:LTFramerDirectionVertical relativeContainer:container];
        double width = [self computeSizeForDirection:LTFramerDirectionHorizontal relativeContainer:container];
        double height = [self computeSizeForDirection:LTFramerDirectionVertical relativeContainer:container];
        
        CGRect frame = CGRectMake(x, y, width, height);
        frame = [self normalizeFrame:frame];
        
        [self setCachedRect:[NSValue valueWithCGRect:frame]];
    }
    return self.cachedRect.CGRectValue;
}

- (double)computeLeadingPositionForDirection:(LTFramerDirection)direction relativeContainer:(CGRect)container
{
    double offset = [self positionComponent:container.origin inDirection:direction];
    double size = [self sizeComponent:container.size inDirection:direction];
    double value = [self computeLeadingPositionForDirection:direction boundingSize:size];
    return offset + value;
}

- (double)computeSizeForDirection:(LTFramerDirection)direction relativeContainer:(CGRect)container
{
    double size = [self sizeComponent:container.size inDirection:direction];
    double value = [self computeSizeForDirection:direction boundingSize:size];
    return value;
}

- (double)computeLeadingPositionForDirection:(LTFramerDirection)direction boundingSize:(double)boundingSize
{
    NSArray* rules = [self.rules skyFramer_filter:^BOOL(LTFramerRule* rule) {
        return rule.property.direction == direction;
    }];
    LTFramerRule* positioningRule = [rules skyFramer_first:^BOOL(LTFramerRule* rule) {
        return rule.property.constraint == LTFramerConstraintPosition;
    }];
    
    if (positioningRule.value) {
        return positioningRule.value.doubleValue;
    }
    
    LTFramerPositionProperty* property = (LTFramerPositionProperty*)positioningRule.property;
    LTFramerRule* leadingPaddingRule = [rules skyFramer_first:^BOOL(LTFramerRule* rule) {
        LTFramerPaddingProperty* property = (LTFramerPaddingProperty*)rule.property;
        return [property isKindOfClass:[LTFramerPaddingProperty class]] && property.padding == LTFramerPaddingLeading;
    }];
    
    if (property.position == LTFramerPositionAlignToLeading) {
        return leadingPaddingRule.value.doubleValue;
    }
    
    LTFramerRule* trailingPaddingRule = [rules skyFramer_first:^BOOL(LTFramerRule* rule) {
        LTFramerPaddingProperty* property = (LTFramerPaddingProperty*)rule.property;
        return [property isKindOfClass:[LTFramerPaddingProperty class]] && property.padding == LTFramerPaddingTrailing;
    }];
    
    double fullSize = boundingSize - leadingPaddingRule.value.doubleValue - trailingPaddingRule.value.doubleValue;
    double usedSize = [self computeSizeForDirection:direction boundingSize:boundingSize];
    
    double offset = fullSize - usedSize;
    if (property.position == LTFramerPositionAlignToCenter) {
        offset /= 2;
    }

    return leadingPaddingRule.value.doubleValue + offset;
}

- (double)computeSizeForDirection:(LTFramerDirection)direction boundingSize:(double)boundingSize
{
    NSArray* rules = [self.rules skyFramer_filter:^BOOL(LTFramerRule* rule) {
        return rule.property.direction == direction;
    }];
    LTFramerRule* sizingRule = [rules skyFramer_first:^BOOL(LTFramerRule* rule) {
        return rule.property.constraint == LTFramerConstraintSize;
    }];
    
    LTFramerSizeProperty* property = (LTFramerSizeProperty*)sizingRule.property;
    if (property.size == LTFramerSizeExact) {
        return sizingRule.value.doubleValue;
    } else {
        LTFramerRule* leadingPaddingRule = [rules skyFramer_first:^BOOL(LTFramerRule* rule) {
            LTFramerPaddingProperty* property = (LTFramerPaddingProperty*)rule.property;
            return [property isKindOfClass:[LTFramerPaddingProperty class]] && property.padding == LTFramerPaddingLeading;
        }];
        LTFramerRule* trailingPaddingRule = [rules skyFramer_first:^BOOL(LTFramerRule* rule) {
            LTFramerPaddingProperty* property = (LTFramerPaddingProperty*)rule.property;
            return [property isKindOfClass:[LTFramerPaddingProperty class]] && property.padding == LTFramerPaddingTrailing;
        }];
        
        double fullSize = boundingSize - leadingPaddingRule.value.doubleValue - trailingPaddingRule.value.doubleValue;
        
        if (property.size == LTFramerSizeScaleToFill) {
            return fullSize;
        } else if (property.size == LTFramerSizeScaleToFit) {
            BOOL subjectIsView = [self.subject isKindOfClass:[UIView class]];
            NSAssert(subjectIsView, @"Fitting is only supported on UIViews as it is using the -sizeThatFits: method");
            if (subjectIsView) {
                CGSize sizeConstraint = [self size:fullSize inDirection:direction else:CGFLOAT_MAX];
                CGSize sizeThatFits = [(UIView*)self.subject sizeThatFits:sizeConstraint];
                double size = [self sizeComponent:sizeThatFits inDirection:direction];
                return MIN(fullSize, size);
            } else {
                return fullSize;
            }
        }
    }
    
    return 0;
}

- (double)positionComponent:(CGPoint)point inDirection:(LTFramerDirection)direction
{
    return direction == LTFramerDirectionHorizontal ? point.x : point.y;
}

- (double)sizeComponent:(CGSize)size inDirection:(LTFramerDirection)direction
{
    return direction == LTFramerDirectionHorizontal ? size.width : size.height;
}

- (CGSize)size:(double)parallel inDirection:(LTFramerDirection)direction else:(double)perpendicular
{
    BOOL isHorizontal = direction == LTFramerDirectionHorizontal;
    return CGSizeMake(isHorizontal ? parallel : perpendicular,
                      isHorizontal ? perpendicular : parallel);
}

- (CGRect)normalizeFrame:(CGRect)frame
{
    if ([[LTFramerConfiguration sharedConfiguration] isHorizontallyMirrored]) {
        CGRect result = frame;
        result.origin.x = self.boundingSize.width - result.origin.x - result.size.width;
        return result;
    } else {
        return frame;
    }
}

+ (NSNumber*)valueOfProperty:(LTFramerSupportedProperty)property forFrame:(CGRect)frame
{
    switch (property)
    {
        case LTFramerSupportedPropertyLeadingX:  return @(CGRectGetMinX(frame));
        case LTFramerSupportedPropertyTrailingX: return @(CGRectGetMaxX(frame));
        case LTFramerSupportedPropertyLeadingY:  return @(CGRectGetMinY(frame));
        case LTFramerSupportedPropertyTrailingY: return @(CGRectGetMaxY(frame));
        case LTFramerSupportedPropertyCenterX:   return @(CGRectGetMidX(frame));
        case LTFramerSupportedPropertyCenterY:   return @(CGRectGetMidY(frame));
        case LTFramerSupportedPropertyWidth:     return @(CGRectGetWidth(frame));
        case LTFramerSupportedPropertyHeight:    return @(CGRectGetHeight(frame));
        default:
        case LTFramerSupportedPropertyNone:      return nil;
    }
}

- (BOOL)isHorizontalPositionProperty:(LTFramerSupportedProperty)property
{
    return property == LTFramerSupportedPropertyLeadingX
        || property == LTFramerSupportedPropertyCenterX
        || property == LTFramerSupportedPropertyTrailingX;
}

+ (LTFramerProperty*)propertyForSupportedProperty:(LTFramerSupportedProperty)property
{
    switch (property)
    {
        case LTFramerSupportedPropertyLeadingX: return [LTFramerPaddingProperty propertyWithDirection:LTFramerDirectionHorizontal padding:LTFramerPaddingLeading];
        case LTFramerSupportedPropertyTrailingX: return [LTFramerPaddingProperty propertyWithDirection:LTFramerDirectionHorizontal padding:LTFramerPaddingTrailing];
        case LTFramerSupportedPropertyLeadingY: return [LTFramerPaddingProperty propertyWithDirection:LTFramerDirectionVertical padding:LTFramerPaddingLeading];
        case LTFramerSupportedPropertyTrailingY: return [LTFramerPaddingProperty propertyWithDirection:LTFramerDirectionVertical padding:LTFramerPaddingTrailing];
        case LTFramerSupportedPropertyCenterX: return [LTFramerPositionProperty propertyWithDirection:LTFramerDirectionHorizontal position:LTFramerPositionAlignToCenter];
        case LTFramerSupportedPropertyCenterY: return [LTFramerPositionProperty propertyWithDirection:LTFramerDirectionVertical position:LTFramerPositionAlignToCenter];
        case LTFramerSupportedPropertyWidth: return [LTFramerSizeProperty propertyWithDirection:LTFramerDirectionHorizontal size:LTFramerSizeExact];
        case LTFramerSupportedPropertyHeight: return [LTFramerSizeProperty propertyWithDirection:LTFramerDirectionVertical size:LTFramerSizeExact];
        default:
        case LTFramerSupportedPropertyNone: return nil;
    }
}

- (void)addRule:(LTFramerRule *)newRule
{
    if ([self.rules containsObject:newRule] == NO) {
        NSArray* existingRulesWithSameProperties = [self.rules skyFramer_filter:^BOOL(LTFramerRule* rule) {
            return [rule.property isEqualToProperty:newRule.property];
        }];
        [self.rules removeObjectsInArray:existingRulesWithSameProperties];
        [self.rules addObject:newRule];
        [self.rulesInScope addObject:newRule];
        [self invalidateCache];
    }
}

- (void)invalidateCache
{
    [self setCachedRect:nil];
}

- (NSArray*)allRules
{
    [self addMissingRulesIfNeeded];
    return [self.rules copy];
}
    
- (void)resetRules
{
    [self setRules:[NSMutableArray array]];
}

- (LTFramerRule*)defaultHorizontalPositioningRule
{
    LTFramerPosition position = LTFramerPositionAlignToLeading;
    if ([self.subject isKindOfClass:[UILabel class]]) {
        position = LTFramerPositionAlignToCenter;
    }
    return [LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal position:position];
}

- (LTFramerRule*)defaultVerticalPositioningRule
{
    return [LTFramerRule ruleWithDirection:LTFramerDirectionVertical position:LTFramerPositionAlignToLeading];
}

- (LTFramerRule*)defaultHorizontalSizingRule
{
    LTFramerSize size = LTFramerSizeScaleToFill;
    if ([self.subject isKindOfClass:[UILabel class]]) {
        size = LTFramerSizeScaleToFit;
    }
    return [LTFramerRule ruleWithDirection:LTFramerDirectionHorizontal size:size];
}

- (LTFramerRule*)defaultVerticalSizingRule
{
    return [LTFramerRule ruleWithDirection:LTFramerDirectionVertical size:LTFramerSizeScaleToFill];
}

- (void)resetScope
{
    self.rulesInScope = [NSMutableArray array];
}

#pragma mark - LTFramerRelativeRuleDelegate

- (void)relativeRuleDeclarationDidModifyRule:(LTFramerRelativeRule*)relativeRule
{
    if (relativeRule.targetProperty != LTFramerSupportedPropertyNone)
    {
        LTFramerRule* rule = [LTFramerRule new];
        [rule setProperty:[LTFramer propertyForSupportedProperty:relativeRule.targetProperty]];
        [rule setPriority:relativeRule.priorityValue];
        
        NSNumber* value = nil;
        if (relativeRule.sourceSubject != nil && relativeRule.sourceProperty != LTFramerSupportedPropertyNone) {
            LTFramer* sourceFramer = [LTFramer framerWithSubject:relativeRule.sourceSubject boundingSize:self.boundingSize];
            CGRect frame = [self normalizeFrame:sourceFramer.subject.frame];
            value = [self.class valueOfProperty:relativeRule.sourceProperty forFrame:frame];
            if (value) {
                //Handling special cases where the translated property is actually a relative padding, not an absolute coordinate
                if (relativeRule.targetProperty == LTFramerSupportedPropertyTrailingX) {
                    value = @(sourceFramer.boundingSize.width - value.doubleValue);
                } else if (relativeRule.targetProperty == LTFramerSupportedPropertyTrailingY) {
                    value = @(sourceFramer.boundingSize.height - value.doubleValue);
                }
                value = @(value.doubleValue * relativeRule.multiplierValue + relativeRule.offsetValue);
            }
        } else if (relativeRule.exactValue != nil) {
            value = relativeRule.exactValue;
        }
        
        [rule setValue:value];
        [self addRule:rule];
    }
}

#pragma mark - LTFramerAbsoluteRuleDelegate

- (void)absoluteRuleDeclaration:(LTFramerAbsoluteRule*)declaration didGenerateNewRule:(LTFramerRule*)rule
{
    [self addRule:rule];
}

- (void)absoluteRuleDeclaration:(LTFramerAbsoluteRule*)declaration didModifyPriority:(LTFramerRulePriority)priority
{
    for (LTFramerRule* rule in self.rulesInScope) {
        [rule setPriority:@(priority)];
    }
}

#pragma mark - Fluent API

- (id<LTFramerAbsoluteRule>)set
{
    [self resetScope];
    return [LTFramerAbsoluteRule absoluteRuleWithDelegate:self];
}

- (id<LTFramerRelativeRule>)make
{
    [self resetScope];
    return [LTFramerRelativeRule relativeRuleWithDelegate:self];
}

@end
