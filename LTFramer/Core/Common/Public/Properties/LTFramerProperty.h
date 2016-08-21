//
//  LTFramerProperty.h
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerDirection.h"

typedef NS_ENUM(NSUInteger, LTFramerConstraint) {
    LTFramerConstraintPosition,
    LTFramerConstraintSize,
    LTFramerConstraintPadding
};

@interface LTFramerProperty : NSObject <NSCopying>

@property (nonatomic, assign) LTFramerDirection direction;
@property (nonatomic, assign) LTFramerConstraint constraint;

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction;

- (BOOL)isEqualToProperty:(LTFramerProperty *)property;

@end
