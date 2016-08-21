//
//  LTFramerAbsoluteRuleProtocol.h
//  Pods
//
//  Created by László Teveli on 2016. 10. 11..
//
//

#import "LTFramerRulePriority.h"

@protocol LTFramer;

@protocol LTFramerAbsoluteRule <NSObject>

@property (nonatomic, nonnull, readonly) id<LTFramer> then;

@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> and;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> with;

@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignCenter;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignCenterX;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignCenterY;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignLeft;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignRight;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignTop;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignBottom;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignTopLeft;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignTopRight;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignBottomLeft;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> alignBottomRight;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> fitWidth;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> fitHeight;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> fillWidth;
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> fillHeight;

@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^width)(double width);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^height)(double height);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^size)(CGSize size);

@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^left)(double padding);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^right)(double padding);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^top)(double padding);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^bottom)(double padding);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^bothSides)(double padding);
@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^paddings)(UIEdgeInsets paddings);

@property (nonatomic, nonnull, readonly) id<LTFramerAbsoluteRule> _Nonnull (^priority)(LTFramerRulePriority priority); //Not yet implemented

@end
