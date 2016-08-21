//
//  UIView+LTFramer.m
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import "UIView+LTFramer.h"
#import "LTFramer+UIKit.h"
#import <objc/runtime.h>

@implementation UIView (LTFramer_BlockConvenience)

- (void)installFrame:(LTFramerBlock)block
{
    [self installFrame:block ignoreTransform:NO];
}

- (void)installFrame:(LTFramerBlock)block inRelativeContainer:(CGRect)rect
{
    [self installFrame:block ignoreTransform:NO inRelativeContainer:rect];
}

- (void)installFrame:(LTFramerBlock)block ignoreTransform:(BOOL)ignoreTransform
{
    LTFramer* framer = [self skyFramerWithInstalledFrame:block];
    if (ignoreTransform) {
        [framer setFrameIgnoringTransform];
    } else {
        [framer setFrame];
    }
}

- (void)installFrame:(LTFramerBlock)block ignoreTransform:(BOOL)ignoreTransform inRelativeContainer:(CGRect)rect
{
    LTFramer* framer = [self skyFramerWithInstalledFrame:block];
    if (ignoreTransform) {
        [framer setFrameIgnoringTransformInRelativeContainer:rect];
    } else {
        [framer setFrameInRelativeContainer:rect];
    }
}

- (LTFramer*)skyFramerWithInstalledFrame:(LTFramerBlock)block
{
    LTFramer* framer = [self skyFramer];    
    [framer resetRules];

    if (block) {
        block(framer);
    }
    
    return framer;
}

- (LTFramer*)skyFramer
{
    LTFramer* framer = objc_getAssociatedObject(self, @selector(skyFramer));
    
    if (framer == nil) {
        framer = [LTFramer framerWithView:self];
        objc_setAssociatedObject(self, @selector(skyFramer), framer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return framer;
}

@end
