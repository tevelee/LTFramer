//
//  LTFramerVirtualBox.m
//  Pods
//
//  Created by László Teveli on 08/09/16.
//
//

#import "LTFramerVirtualBox.h"

@implementation LTFramerVirtualBox

+ (instancetype)boxWithLayout:(LTFramerLayoutBlock)layout
{
    LTFramerVirtualBox* box = [self new];
    [box setLayout:layout];
    return box;
}

- (void)setFrame:(CGRect)frame
{
    self.layout(frame);
}

@end
