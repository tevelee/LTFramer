//
//  LTFramerProtocol.h
//  Pods
//
//  Created by László Teveli on 2016. 10. 11..
//
//

#import "LTFramerAbsoluteRuleProtocol.h"
#import "LTFramerRelativeRuleProtocol.h"

@protocol LTFramer <NSObject>

@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> set;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> make;

- (void)setFrame;
- (void)setFrameIgnoringTransform;
- (CGRect)computedFrame;

- (void)setFrameInRelativeContainer:(CGRect)container;
- (void)setFrameIgnoringTransformInRelativeContainer:(CGRect)container;
- (CGRect)computedFrameInRelativeContainer:(CGRect)container;

@end
