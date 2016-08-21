//
//  LTFramerAbsoluteRule.h
//  Pods
//
//  Created by László Teveli on 2016. 10. 10..
//
//

#import "LTFramerRule.h"
#import "LTFramerProtocol.h"
#import "LTFramerAbsoluteRuleProtocol.h"

@class LTFramerAbsoluteRule;

@protocol LTFramerAbsoluteRuleDelegate <LTFramer>

- (void)absoluteRuleDeclaration:(LTFramerAbsoluteRule* _Nonnull)rule didGenerateNewRule:(LTFramerRule* _Nonnull)rule;
- (void)absoluteRuleDeclaration:(LTFramerAbsoluteRule* _Nonnull)rule didModifyPriority:(LTFramerRulePriority)priority;

@end

@interface LTFramerAbsoluteRule : NSObject <LTFramerAbsoluteRule>

@property (nonatomic, nullable, weak) id<LTFramerAbsoluteRuleDelegate> delegate;

+ (instancetype _Nonnull)absoluteRuleWithDelegate:(id<LTFramerAbsoluteRuleDelegate> _Nonnull)delegate;

@end
