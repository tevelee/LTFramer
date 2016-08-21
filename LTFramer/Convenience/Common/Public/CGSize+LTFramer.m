//
//  CGSize+LTFramer.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "CGSize+LTFramer.h"

CGSize CGSizeCeilMake(CGFloat width, CGFloat height)
{
    return CGSizeCeil(CGSizeMake(width, height));
}

CGSize CGSizeCeil(CGSize size)
{
    CGFloat width = ceilf(size.width);
    CGFloat height = ceilf(size.height);
    return CGSizeMake(width, height);
}

CGSize CGSizeFloorMake(CGFloat width, CGFloat height)
{
    return CGSizeFloor(CGSizeMake(width, height));
}

CGSize CGSizeFloor(CGSize size)
{
    CGFloat width = floorf(size.width);
    CGFloat height = floorf(size.height);
    return CGSizeMake(width, height);
}
