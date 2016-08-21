//
//  UIView+LTFramer.m
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import "UIView+LTFramerConvenience.h"

@implementation UIView (LTFramer_Convenience)

- (void)addTo:(UIView*)view
{
    [view addSubview:self];
}

- (CGFloat)dumpTransformFloat:(CGFloat(^)(UIView* view))block
{
    CGAffineTransform originalTransform = self.transform;
    [self setTransform:CGAffineTransformIdentity];
    CGFloat result = block(self);
    [self setTransform:originalTransform];
    return result;
}

- (CGPoint)dumpTransformPoint:(CGPoint(^)(UIView* view))block
{
    CGAffineTransform originalTransform = self.transform;
    [self setTransform:CGAffineTransformIdentity];
    CGPoint result = block(self);
    [self setTransform:originalTransform];
    return result;
}

- (CGSize)dumpTransformSize:(CGSize(^)(UIView* view))block
{
    CGAffineTransform originalTransform = self.transform;
    [self setTransform:CGAffineTransformIdentity];
    CGSize result = block(self);
    [self setTransform:originalTransform];
    return result;
}

- (CGFloat)skyFramer_minX:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetMinX(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_minY:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetMinY(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_midX:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetMidX(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_midY:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetMidY(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_maxX:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetMaxX(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_maxY:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetMaxY(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_width:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetWidth(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGFloat)skyFramer_height:(BOOL)ignoreTransform
{
    CGFloat(^block)(UIView*) = ^CGFloat(UIView* view) {
        return CGRectGetHeight(view.frame);
    };
    return ignoreTransform ? [self dumpTransformFloat:block] : block(self);
}

- (CGPoint)skyFramer_origin:(BOOL)ignoreTransform
{
    CGPoint(^block)(UIView*) = ^CGPoint(UIView* view) {
        return view.frame.origin;
    };
    return ignoreTransform ? [self dumpTransformPoint:block] : block(self);
}

- (CGSize)skyFramer_size:(BOOL)ignoreTransform
{
    CGSize(^block)(UIView*) = ^CGSize(UIView* view) {
        return view.frame.size;
    };
    return ignoreTransform ? [self dumpTransformSize:block] : block(self);
}

@end
