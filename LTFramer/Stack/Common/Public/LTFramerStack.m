//
//  LTFramerVirtualBox.m
//  Pods
//
//  Created by László Teveli on 08/09/16.
//
//

#import "LTFramerStack.h"
#import "LTFramerStackElement.h"
#import "NSArray+LTFramer.h"
#import "NSDictionary+LTFramer.h"

@interface LTFramerStack ()

@property (nonatomic, strong) NSArray<LTFramerStackElement*>* elements;

@property (nonatomic, assign) CGSize cachedElementsSize;
@property (nonatomic, strong) NSDictionary<NSString*, NSValue*>* cachedElementFrames;

@property (nonatomic, strong) NSMutableDictionary<NSValue*, NSValue*>* cachedSizes;

@end

@implementation LTFramerStack

+ (instancetype)stackWithSubjects:(NSArray<LTFramerStackSubject>*)subjects
{
    LTFramerStack* stack = [self new];
    [stack setSubjects:subjects];
    return stack;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cachedSizes = [NSMutableDictionary dictionary];
        self.properties = [LTFramerStackProperties new];
    }
    return self;
}

#pragma mark - Setters

- (void)setBoundingSize:(NSValue *)boundingSize
{
    _boundingSize = boundingSize;
    [self buildElements];
    [self prepareFrames];
}

- (void)setSubjects:(NSArray<LTFramerStackSubject> *)subjects
{
    _subjects = subjects;
    [self buildElements];
}

- (void)setProperties:(LTFramerStackProperties *)properties
{
    _properties = properties;
    [self buildElements];
}

#pragma mark - Main

- (void)prepareFrames
{
    CGSize size = self.fullBoundingSize;
    if (CGSizeEqualToSize(size, self.cachedElementsSize) == NO) {
        self.cachedElementsSize = size;
        self.cachedElementFrames = [self framesWithSize:size];
    }
}

- (NSDictionary<NSString*, NSValue*>*)framesWithSize:(CGSize)boundingSize
{
    if (self.elements.count == 0) {
        return @{};
    }
    
    double maxSize = [self.elements skyFramer_sum:^double(LTFramerStackElement* element) {
        return element.sizeRange.max;
    }];
    
    double minimumPriority = [self.elements skyFramer_min:^double(LTFramerStackElement* element) {
        return element.priority;
    }];
    double maximumPriority = [self.elements skyFramer_max:^double(LTFramerStackElement* element) {
        return element.priority;
    }];
    
    NSMutableDictionary* elementSizesInParallel = [[[self.elements skyFramer_dictionaryUsingKey:^id<NSCopying>(LTFramerStackElement* element) {
        return element.identifier;
    }] skyFramer_map:^id(id<LTFramerStackElement> key, LTFramerStackElement* element) {
        return @(element.sizeRange.max);
    }] mutableCopy];
    
    double priority = minimumPriority;
    double diff = maxSize - [self sizeComponent:boundingSize inDirection:self.properties.direction];
    while (fabs(diff) > FLT_EPSILON && priority <= maximumPriority) {
        NSArray* elements = [self.elements skyFramer_filter:^BOOL(LTFramerStackElement* element) {
            return element.priority == priority;
        }];
        
        if (elements.count > 0) {
            double possibleSubstraction = [elements skyFramer_sum:^double(LTFramerStackElement* element) {
                return element.sizeRange.max - element.sizeRange.min;
            }];
            double substraction = MIN(possibleSubstraction, diff);
            
            double allSubstractions = 0;
            for (LTFramerStackElement* element in elements) {
                double diff = element.sizeRange.max - element.sizeRange.min;
                double ratio = diff / possibleSubstraction;
                double sizeToSubstract = MIN(ratio * substraction, diff);
                
                allSubstractions += sizeToSubstract;
                elementSizesInParallel[element.identifier] = @([elementSizesInParallel[element.identifier] doubleValue] - sizeToSubstract);
            }
            
            diff -= allSubstractions;
        }
        
        priority += 1;
    }
    
    NSDictionary* elementSizesInPerpendicular = [[[self.elements skyFramer_filter:^BOOL(LTFramerStackElement* element) {
        return element.alignment != LTFramerAlignStretchToFill;
    }] skyFramer_dictionaryUsingKey:^id<NSCopying>(LTFramerStackElement* element) {
        return element.identifier;
    }] skyFramer_map:^id(id<LTFramerStackElement> key, LTFramerStackElement* element) {
        NSValue* exactSize = self.properties.itemSize ?: element.subject.stackProperties.exactSize;
        if (exactSize) {
            double size = [self sizeComponent:exactSize.CGSizeValue inDirection:self.perpendicularDirection];
            return @(MIN(size, self.fullSizeInPerpendicular));
        } else {
            double itemSize = [elementSizesInParallel[element.identifier] doubleValue];
            CGSize sizeConstraint = [self sizeInDirection:itemSize else:self.fullSizeInPerpendicular];
            CGSize fittedSize = [element.subject sizeThatFits:sizeConstraint];
            fittedSize = CGSizeMake(MIN(sizeConstraint.width, fittedSize.width),
                                    MIN(sizeConstraint.height, fittedSize.height));
            return @([self sizeComponent:fittedSize inDirection:self.perpendicularDirection]);
        }
    }];
    
    NSMutableDictionary* elements = [NSMutableDictionary dictionaryWithCapacity:self.subjects.count];
    for (LTFramerStackElement* element in self.elements) {
        BOOL isFill = element.alignment == LTFramerAlignStretchToFill;
        
        double parallelSize = [elementSizesInParallel[element.identifier] doubleValue];
        
        double perpendicularSize = isFill ? [self sizeComponent:boundingSize inDirection:self.perpendicularDirection] : [elementSizesInPerpendicular[element.identifier] doubleValue];
        
        double parallelPosition = [[self.elements skyFramer_until:^BOOL(LTFramerStackElement* current) {
            return element.subject == current.subject;
        }] skyFramer_sum:^double(LTFramerStackElement* current) {
            return [elementSizesInParallel[current.identifier] doubleValue];
        }];
        
        double perpendicularPosition = [self positionBasedOnAlignment:element.alignment withSize:perpendicularSize availableSize:[self sizeComponent:boundingSize inDirection:self.perpendicularDirection]];
        
        double x = [self valueInDirection:parallelPosition else:perpendicularPosition];
        double y = [self valueInDirection:perpendicularPosition else:parallelPosition];
        double width = [self valueInDirection:parallelSize else:perpendicularSize];
        double height = [self valueInDirection:perpendicularSize else:parallelSize];
        
        elements[element.identifier] = [NSValue valueWithCGRect:CGRectMake(x, y, width, height)];
    }
    return elements;
}

- (LTFramerDirection)perpendicularDirection
{
    return self.properties.direction == LTFramerDirectionHorizontal ? LTFramerDirectionVertical : LTFramerDirectionHorizontal;
}

- (double)sizeComponent:(CGSize)size inDirection:(LTFramerDirection)direction
{
    return direction == LTFramerDirectionHorizontal ? size.width : size.height;
}

- (double)valueInDirection:(double)parallel else:(double)perpendicular
{
    return self.properties.direction == LTFramerDirectionHorizontal ? parallel : perpendicular;
}

- (CGSize)sizeInDirection:(double)parallel else:(double)perpendicular
{
    return CGSizeMake([self valueInDirection:parallel else:perpendicular],
                      [self valueInDirection:perpendicular else:parallel]);
}

- (double)positionBasedOnAlignment:(LTFramerStackAlignment)alignment withSize:(double)size availableSize:(double)availableSize
{
    switch (alignment) {
        default:
        case LTFramerAlignStretchToFill:
        case LTFramerAlignLeading: return 0;
        case LTFramerAlignTrailing: return availableSize - size;
        case LTFramerAlignCenter: return (availableSize - size) / 2.0;
    }
}

- (CGRect)determineFrameForSubject:(LTFramerStackSubject)subject
{
    if ([self.subjects containsObject:subject]) {
        NSString* identifier = [[self.elements skyFramer_first:^BOOL(LTFramerStackElement* element) {
            return element.subject == subject;
        }] identifier];
        NSValue* size = self.cachedElementFrames[identifier];
        if (size == nil) {
            [self prepareFrames];
            size = self.cachedElementFrames[identifier];
        }
        return size.CGRectValue;
    } else {
        return CGRectZero;
    }
}

- (void)buildElements
{
    self.elements = @[];
    
    NSMutableArray<LTFramerStackElement*>* elements = [NSMutableArray arrayWithCapacity:self.subjects.count * 3];
    
    for (LTFramerStackSubject subject in self.subjects) {
        LTFramerStackElement* paddingBefore = [self newElement:^(LTFramerStackElement* element){
            LTFramerRange sizeRange;
            
            if (subject.stackProperties.paddingBefore) {
                double padding = [self normalizeSize:subject.stackProperties.paddingBefore.doubleValue];
                sizeRange = LTFramerRangeMake(padding, padding);
            } else {
                BOOL isLeading = [self.subjects.firstObject isEqual:subject];
                sizeRange = isLeading ? [self defaultLeadingPadding] : [self defaultInterItemSpacing:YES];
            }
            
            sizeRange = LTFramerRangeMake([self normalizeSize:sizeRange.min], [self normalizeSize:sizeRange.max]);
            sizeRange = LTFramerRangeMake(sizeRange.min, MAX(sizeRange.min, sizeRange.max));
            
            [element setSizeRange:sizeRange];
            
            NSInteger priority = [self priorityForRange:sizeRange isContent:NO];
            [element setPriority:priority];
        }];
        
        LTFramerStackElement* paddingAfter = [self newElement:^(LTFramerStackElement* element){
            LTFramerRange sizeRange;
            
            if (subject.stackProperties.paddingAfter) {
                double padding = [self normalizeSize:subject.stackProperties.paddingAfter.doubleValue];
                sizeRange = LTFramerRangeMake(padding, padding);
            } else {
                BOOL isTrailing = [self.subjects.lastObject isEqual:subject];
                sizeRange = isTrailing ? [self defaultTrailingPadding] : [self defaultInterItemSpacing:YES];
            }
            
            sizeRange = LTFramerRangeMake([self normalizeSize:sizeRange.min], [self normalizeSize:sizeRange.max]);
            sizeRange = LTFramerRangeMake(sizeRange.min, MAX(sizeRange.min, sizeRange.max));
            
            [element setSizeRange:sizeRange];
            
            NSInteger priority = [self priorityForRange:sizeRange isContent:NO];
            [element setPriority:priority];
        }];
        
        LTFramerStackElement* element = [self newElement:^(LTFramerStackElement* element){
            [element setSubject:subject];
            
            LTFramerRange sizeRange;
            NSValue* exactSize = self.properties.itemSize ?: subject.stackProperties.exactSize;
            if (exactSize) {
                double size = [self sizeComponent:exactSize.CGSizeValue inDirection:self.properties.direction];
                sizeRange = LTFramerRangeMake(size, size);
            } else {
                CGSize fittedSize = [subject sizeThatFits:self.fullBoundingSize];
                double size = [self sizeComponent:fittedSize inDirection:self.properties.direction];
                sizeRange = LTFramerRangeMake(size, size);
            }
            
            if ([self canGrow:subject]) {
                sizeRange = LTFramerRangeMake(sizeRange.min, self.fullSizeInParallel);
            }
            if ([self canShrink:subject]) {
                sizeRange = LTFramerRangeMake(0, sizeRange.max);
            }
            
            sizeRange = LTFramerRangeMake([self normalizeSize:sizeRange.min], [self normalizeSize:sizeRange.max]);
            sizeRange = LTFramerRangeMake(sizeRange.min, MAX(sizeRange.min, sizeRange.max));
            
            [element setSizeRange:sizeRange];
            
            NSInteger priority = [self priorityForRange:sizeRange isContent:NO];
            [element setPriority:priority];
            
            LTFramerStackAlignment alignment = [self alignmentFromIndividualAlignment:subject.stackProperties.alignment];
            [element setAlignment:alignment];
        }];
        
        [elements addObject:paddingBefore];
        [elements addObject:element];
        [elements addObject:paddingAfter];
    }
    self.elements = elements;
}

- (LTFramerStackElement*)newElement:(void(^)(LTFramerStackElement* element))block
{
    LTFramerStackElement* element = [LTFramerStackElement new];
    block(element);
    return element;
}

- (BOOL)canGrow:(LTFramerStackSubject)element
{
    if (element.stackProperties.canGrow) {
        return element.stackProperties.canGrow.boolValue;
    } else {
        return self.properties.itemsCanGrow;
    }
}

- (BOOL)canShrink:(LTFramerStackSubject)element
{
    if (element.stackProperties.canShrink) {
        return element.stackProperties.canShrink.boolValue;
    } else {
        return self.properties.itemsCanShrink;
    }
}

- (LTFramerStackAlignment)alignmentFromIndividualAlignment:(LTFramerIndividualAlignment)alignment
{
    switch (alignment) {
        default:
        case LTFramerIndividualAlignmentInherited: return self.properties.alignment;
        case LTFramerIndividualAlignmentCenter: return LTFramerAlignCenter;
        case LTFramerIndividualAlignmentLeading: return LTFramerAlignLeading;
        case LTFramerIndividualAlignmentTrailing: return LTFramerAlignTrailing;
        case LTFramerIndividualAlignmentStretchToFill: return LTFramerAlignStretchToFill;
    }
}

- (LTFramerRange)defaultLeadingPadding
{
    double spacing = self.properties.spacesCanGrow ? self.fullSizeInParallel : self.properties.spacing;
    switch (self.properties.justification) {
        default:
        case LTFramerJustifySpaceBetween:
        case LTFramerJustifyLeading: return LTFramerRangeMake(0, 0);
        case LTFramerJustifyTrailing:
        case LTFramerJustifyCenter: return LTFramerRangeMake(0, spacing);
        case LTFramerJustifySpaceAround: return LTFramerRangeMake(self.properties.spacing / 2.0, spacing);
    }
}

- (LTFramerRange)defaultInterItemSpacing:(BOOL)isHalfSpacing
{
    double spacing = self.properties.spacing;
    if (isHalfSpacing) {
        spacing /= 2;
    }

    switch (self.properties.justification) {
        default:
        case LTFramerJustifyLeading:
        case LTFramerJustifyCenter:
        case LTFramerJustifyTrailing: return LTFramerRangeMake(spacing, spacing);
        case LTFramerJustifySpaceBetween:
        case LTFramerJustifySpaceAround: return LTFramerRangeMake(spacing, self.properties.spacesCanGrow ? self.fullSizeInParallel : spacing);
    }
}

- (LTFramerRange)defaultTrailingPadding
{
    double spacing = self.properties.spacesCanGrow ? self.fullSizeInParallel : self.properties.spacing;
    switch (self.properties.justification) {
        default:
        case LTFramerJustifySpaceBetween:
        case LTFramerJustifyTrailing: return LTFramerRangeMake(0, 0);
        case LTFramerJustifyLeading:
        case LTFramerJustifyCenter: return LTFramerRangeMake(0, spacing);
        case LTFramerJustifySpaceAround: return LTFramerRangeMake(self.properties.spacing / 2.0, spacing);
    }
}

- (NSInteger)priorityForRange:(LTFramerRange)range isContent:(BOOL)isContent
{
    double priority = 0;
    
    if (isContent) {
        priority += 1;
    }
    
    if (range.min == range.max) {
        priority += 1;
    }
    
    if (range.min > 0) {
        priority += 1;
    }
    
    if (range.max < self.fullSizeInParallel) {
        priority += 1;
    }
    
    return priority;
}

- (CGSize)fullBoundingSize
{
    return self.boundingSize ? self.boundingSize.CGSizeValue : [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (double)fullSizeInParallel
{
    return [self sizeComponent:self.fullBoundingSize inDirection:self.properties.direction];
}

- (double)fullSizeInPerpendicular
{
    return [self sizeComponent:self.fullBoundingSize inDirection:self.perpendicularDirection];
}

- (double)normalizeSize:(double)size
{
    return MIN(self.fullSizeInParallel, MAX(0, size));
}

- (CGSize)sizeThatFits:(CGSize)sizeConstraint
{
    NSValue* sizeValue = [NSValue valueWithCGSize:sizeConstraint];
    NSValue* cached = self.cachedSizes[sizeValue];
    if (cached) {
        return cached.CGSizeValue;
    } else {
        NSArray<NSValue*>* frames = [[self framesWithSize:sizeConstraint] allValues];
        
        if (frames.count == 0) {
            return CGSizeZero;
        }
        
        BOOL isHorizontal = self.properties.direction == LTFramerDirectionHorizontal;
        
        double width = 0;
        if (isHorizontal) {
            width = [frames skyFramer_sum:^double(NSValue* value) {
                return CGRectGetWidth(value.CGRectValue);
            }];
        } else {
            width = [frames skyFramer_max:^double(NSValue* value) {
                return CGRectGetWidth(value.CGRectValue);
            }];
        }
        
        double height = 0;
        if (isHorizontal) {
            height = [frames skyFramer_max:^double(NSValue* value) {
                return CGRectGetHeight(value.CGRectValue);
            }];
        } else {
            height = [frames skyFramer_sum:^double(NSValue* value) {
                return CGRectGetHeight(value.CGRectValue);
            }];
        }
        
        CGSize fittedSize = CGSizeMake(width, height);
        
        self.cachedSizes[sizeValue] = [NSValue valueWithCGSize:fittedSize];
        return fittedSize;
    }
}

@end
