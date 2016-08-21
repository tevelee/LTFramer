//
//  NSObject+LTFramerConvenience.m
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "NSObject+LTFramerConvenience.h"

@implementation NSObject (LTFramerConvenience)

+ (instancetype)configureNew:(LTFramerConfigureBlock)block
{
    return [[self new] configure:block];
}

- (instancetype)configure:(LTFramerConfigureBlock)block
{
    if (block) {
        block(self);
    }
    return self;
}

@end
