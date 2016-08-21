//
//  LTFramerProperty.h
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerProperty.h"

typedef NS_ENUM(NSUInteger, LTFramerPadding) {
    LTFramerPaddingLeading,
    LTFramerPaddingTrailing
};

@interface LTFramerPaddingProperty : LTFramerProperty

@property (nonatomic, assign) LTFramerPadding padding;

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction padding:(LTFramerPadding)padding;

@end
