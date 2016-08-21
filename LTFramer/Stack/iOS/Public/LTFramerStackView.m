//
//  LTFramerStackView.m
//  Pods
//
//  Created by László Teveli on 16/09/16.
//
//

#import "LTFramerStackView.h"
#import "NSArray+LTFramer.h"
#import "UIView+LTFramer.h"
#import "UIView+LTFramerStack.h"

@interface LTFramerStackView ()

@property (nonatomic, strong, readwrite) LTFramerStack* stack;

@end

@implementation LTFramerStackView

+ (instancetype)stackViewWithViews:(NSArray<UIView *> *)views
{
    return [[LTFramerStackView alloc] initWithViews:views];
}

- (instancetype)initWithViews:(NSArray<UIView *> *)views
{
    self = [super init];
    if (self) {
        self.stack = [LTFramerStack stackWithSubjects:views];
        
        [views skyFramer_forEach:^(UIView* view) {
            [self addSubview:view];
        }];
    }
    return self;
}

- (void)addArrangedSubview:(UIView *)view
{
    [self addSubview:view];
    
    NSMutableArray* subjects = [self.stack.subjects mutableCopy];
    [subjects addObject:view];
    [self.stack setSubjects:subjects.copy];
}

- (void)removeArrangedSubview:(UIView *)view
{
    [view removeFromSuperview];
    
    NSMutableArray* subjects = [self.stack.subjects mutableCopy];
    [subjects removeObject:view];
    [self.stack setSubjects:subjects.copy];
}

- (void)insertArrangedSubview:(UIView *)view atIndex:(NSUInteger)stackIndex
{
    [self insertSubview:view atIndex:stackIndex];
    
    NSMutableArray* subjects = [self.stack.subjects mutableCopy];
    [subjects insertObject:view atIndex:stackIndex];
    [self.stack setSubjects:subjects.copy];
}

- (void)setProperties:(LTFramerStackProperties *)properties
{
    [self.stack setProperties:properties];
}

- (LTFramerStackProperties *)properties
{
    return self.stack.properties;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.stack setBoundingSize:[NSValue valueWithCGSize:frame.size]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.stack.subjects skyFramer_forEach:^(LTFramerStackSubject view) {
        CGRect frame = [self.stack determineFrameForSubject:view];
        [view setFrame:frame];
    }];
}

@end
