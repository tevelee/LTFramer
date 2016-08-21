//
//  LTFramerRelativeRuleProtocol.h
//  Pods
//
//  Created by László Teveli on 2016. 10. 11..
//
//

#import "LTFramerRulePriority.h"
#import "LTFramerSubject.h"

@protocol LTFramer;

@protocol LTFramerRelativeRule <NSObject>

@property (nonatomic, nonnull, readonly) id<LTFramer> then;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> equalTo;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> same;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> _Nonnull (^of)(LTFramerSubject _Nonnull subject);

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> left;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> right;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> top;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> bottom;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> width;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> height;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> centerX;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> centerY;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> with;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> the;
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> and;

@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> _Nonnull (^offset)(double offset);
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> _Nonnull (^multiplier)(double multiplier);
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> _Nonnull (^value)(double value);
@property (nonatomic, nonnull, readonly) id<LTFramerRelativeRule> _Nullable (^priority)(LTFramerRulePriority priority); //Not yet implemented

@end
