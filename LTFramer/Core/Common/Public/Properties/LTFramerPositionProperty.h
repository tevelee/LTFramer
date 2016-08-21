//
//  LTFramerProperty.h
//  Pods
//
//  Created by László Teveli on 07/09/16.
//
//

#import "LTFramerProperty.h"

typedef NS_ENUM(NSUInteger, LTFramerPosition) {
    LTFramerPositionExact,
    LTFramerPositionAlignToLeading,
    LTFramerPositionAlignToCenter,
    LTFramerPositionAlignToTrailing
};

@interface LTFramerPositionProperty : LTFramerProperty

@property (nonatomic, assign) LTFramerPosition position;

+ (instancetype)propertyWithDirection:(LTFramerDirection)direction position:(LTFramerPosition)position;

@end
