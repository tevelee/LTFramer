//
//  LTFramerFrameInstallable.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "LTFramer.h"

typedef void(^LTFramerBlock)(LTFramer* framer);

@protocol LTFramerFrameInstallable <NSObject>

- (void)installFrame:(LTFramerBlock)block;
- (void)installFrame:(LTFramerBlock)block ignoreTransform:(BOOL)ignoreTransform;

- (void)installFrame:(LTFramerBlock)block inRelativeContainer:(CGRect)rect;
- (void)installFrame:(LTFramerBlock)block ignoreTransform:(BOOL)ignoreTransform inRelativeContainer:(CGRect)rect;

@end
