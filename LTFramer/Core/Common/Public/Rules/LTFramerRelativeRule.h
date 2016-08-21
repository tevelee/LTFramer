//
//  LTFramerRelativeRule.h
//  Pods
//
//  Created by László Teveli on 06/09/16.
//
//

#import "LTFramerRule.h"
#import "LTFramerSubject.h"
#import "LTFramerProtocol.h"
#import "LTFramerRelativeRuleProtocol.h"

typedef NS_ENUM(NSUInteger, LTFramerRelation) {
    LTFramerRelationNone,
    LTFramerRelationEquality,
    LTFramerRelationLessThan,
    LTFramerRelationLessThanOrEqual,
    LTFramerRelationGreaterThan,
    LTFramerRelationGreaterThanOrEqual
};

typedef NS_ENUM(NSUInteger, LTFramerSupportedProperty) {
    LTFramerSupportedPropertyNone,
    LTFramerSupportedPropertyLeadingX,
    LTFramerSupportedPropertyCenterX,
    LTFramerSupportedPropertyTrailingX,
    LTFramerSupportedPropertyWidth,
    LTFramerSupportedPropertyLeadingY,
    LTFramerSupportedPropertyCenterY,
    LTFramerSupportedPropertyTrailingY,
    LTFramerSupportedPropertyHeight
};

@class LTFramerRelativeRule;

@protocol LTFramerRelativeRuleDelegate <LTFramer>

- (void)relativeRuleDeclarationDidModifyRule:(LTFramerRelativeRule* _Nonnull)rule;

@end

@interface LTFramerRelativeRule : NSObject <LTFramerRelativeRule>

@property (nonatomic, nullable, weak) id<LTFramerRelativeRuleDelegate> delegate;

@property (nonatomic, assign) LTFramerRelation relation;
@property (nonatomic, assign) LTFramerDirection direction;

@property (nonatomic, nullable, weak) LTFramerSubject sourceSubject;
@property (nonatomic, assign) LTFramerSupportedProperty sourceProperty;
@property (nonatomic, assign) LTFramerSupportedProperty targetProperty;

@property (nonatomic, nullable, strong) NSNumber* priorityValue;
@property (nonatomic, nullable, strong) NSNumber* exactValue;
@property (nonatomic, assign) double offsetValue;
@property (nonatomic, assign) double multiplierValue;

+ (instancetype _Nonnull)relativeRuleWithDelegate:(id<LTFramerRelativeRuleDelegate> _Nonnull)delegate;

@end
