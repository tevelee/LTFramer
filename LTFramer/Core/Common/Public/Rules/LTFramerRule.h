//
//  LTFramerRule.h
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import <Foundation/Foundation.h>
#import "LTFramerSizeProperty.h"
#import "LTFramerPaddingProperty.h"
#import "LTFramerPositionProperty.h"

@interface LTFramerRule : NSObject <NSCopying>

@property (nonatomic, strong) LTFramerProperty* property;
@property (nonatomic, strong) NSNumber* value;
@property (nonatomic, strong) NSNumber* priority;

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction position:(LTFramerPosition)position;
+ (instancetype)ruleWithDirection:(LTFramerDirection)direction exactPosition:(double)position;

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction size:(LTFramerSize)size;
+ (instancetype)ruleWithDirection:(LTFramerDirection)direction exactSize:(double)size;

+ (instancetype)ruleWithDirection:(LTFramerDirection)direction padding:(LTFramerPadding)padding value:(double)value;

- (BOOL)isEqualToRule:(LTFramerRule *)rule;

@end
