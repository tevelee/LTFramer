//
//  CGRect+LTFramer.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "CGRect+LTFramer.h"

CGRect CGRectCreate(CGPoint origin, CGSize size)
{
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

CGRect CGRectIntegralMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    return CGRectIntegral(CGRectMake(x, y, width, height));
}
