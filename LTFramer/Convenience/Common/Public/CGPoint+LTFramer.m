//
//  CGSize+LTFramer.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "CGPoint+LTFramer.h"

CGPoint CGPointCeilMake(CGFloat x, CGFloat y)
{
    return CGPointCeil(CGPointMake(x, y));
}

CGPoint CGPointCeil(CGPoint point)
{
    CGFloat x = ceilf(point.x);
    CGFloat y = ceilf(point.y);
    return CGPointMake(x, y);
}

CGPoint CGPointFloorMake(CGFloat x, CGFloat y)
{
    return CGPointFloor(CGPointMake(x, y));
}

CGPoint CGPointFloor(CGPoint point)
{
    CGFloat x = floorf(point.x);
    CGFloat y = floorf(point.y);
    return CGPointMake(x, y);
}
