//
//  UIView+LTFramer.h
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import <UIKit/UIKit.h>

@interface UIView (LTFramer_Convenience)

- (void)addTo:(UIView*)view;

- (CGFloat)skyFramer_minX:(BOOL)ignoreTransform;
- (CGFloat)skyFramer_minY:(BOOL)ignoreTransform;

- (CGFloat)skyFramer_midX:(BOOL)ignoreTransform;
- (CGFloat)skyFramer_midY:(BOOL)ignoreTransform;

- (CGFloat)skyFramer_maxX:(BOOL)ignoreTransform;
- (CGFloat)skyFramer_maxY:(BOOL)ignoreTransform;

- (CGFloat)skyFramer_width:(BOOL)ignoreTransform;
- (CGFloat)skyFramer_height:(BOOL)ignoreTransform;

- (CGPoint)skyFramer_origin:(BOOL)ignoreTransform;
- (CGSize)skyFramer_size:(BOOL)ignoreTransform;

@end
