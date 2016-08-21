//
//  LTFramerStackProperties.h
//  Pods
//
//  Created by László Teveli on 16/09/16.
//
//

#import <Foundation/Foundation.h>
#import "LTFramerDirection.h"
#import "LTFramerStackAlignment.h"

typedef NS_ENUM(NSUInteger, LTFramerJustification) {
    LTFramerJustifyLeading,
    LTFramerJustifyTrailing,
    LTFramerJustifyCenter,
    LTFramerJustifySpaceBetween,
    LTFramerJustifySpaceAround
};

typedef NS_ENUM(NSUInteger, LTFramerOverflowBehaviour) {
    LTFramerOverflowBehaviourAllowOverflow,
    //LTFramerOverflowBehaviourClipping,
    //LTFramerOverflowBehaviourBreakConstraints is not yet implemented
};

@interface LTFramerStackProperties : NSObject

@property (nonatomic, assign) double spacing;
@property (nonatomic, assign) BOOL spacesCanGrow;
@property (nonatomic, assign) BOOL itemsCanGrow;
@property (nonatomic, assign) BOOL itemsCanShrink;
@property (nonatomic, strong) NSValue* itemSize;
@property (nonatomic, assign) LTFramerDirection direction;
@property (nonatomic, assign) LTFramerJustification justification;
@property (nonatomic, assign) LTFramerStackAlignment alignment;
@property (nonatomic, assign) LTFramerOverflowBehaviour overflowBehaviour;

@end
