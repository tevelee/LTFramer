//
//  LTFramerStackElement.m
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "LTFramerStackElement.h"

LTFramerRange LTFramerRangeMake(double min, double max)
{
    LTFramerRange range;
    range.min = min;
    range.max = max;
    return range;
}

@implementation LTFramerStackElement

- (instancetype)init
{
    self = [super init];
    if (self) {
        _identifier = [[NSUUID UUID] UUIDString];
    }
    return self;
}

@end
