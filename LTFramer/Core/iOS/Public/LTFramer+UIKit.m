//
//  LTFramer+UIView.m
//  Pods
//
//  Created by László Teveli on 25/09/16.
//
//

#import "LTFramer+UIKit.h"
#import "UIView+LTFramer.h"

@implementation LTFramer (UIKit)

+ (instancetype)framerWithView:(UIView*)view
{
    return [self framerWithSubject:view boundingSize:view.superview.bounds.size];
}

@end
