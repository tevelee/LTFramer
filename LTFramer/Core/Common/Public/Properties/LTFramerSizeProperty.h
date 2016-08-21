//
//  LTFramerProperty.h
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerProperty.h"

typedef NS_ENUM(NSUInteger, LTFramerSize) {
    LTFramerSizeExact,
    LTFramerSizeScaleToFill,
    LTFramerSizeScaleToFit
};

@interface LTFramerSizeProperty : LTFramerProperty

@property (nonatomic, assign) LTFramerSize size;

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction size:(LTFramerSize)size;

@end
