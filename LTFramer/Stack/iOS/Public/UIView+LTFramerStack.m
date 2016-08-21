//
//  UIView+LTFramer_Stack.m
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "UIView+LTFramerStack.h"
#import <objc/runtime.h>

@implementation UIView (LTFramerStack)

- (LTFramerStackElementProperties*)stackProperties
{
    LTFramerStackElementProperties* properties = objc_getAssociatedObject(self, @selector(stackProperties));
    if (properties == nil) {
        properties = [LTFramerStackElementProperties new];
        [self setStackProperties:properties];
    }
    return properties;
}

- (void) setStackProperties:(LTFramerStackElementProperties *)stackProperties
{
    objc_setAssociatedObject(self, @selector(stackProperties), stackProperties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
