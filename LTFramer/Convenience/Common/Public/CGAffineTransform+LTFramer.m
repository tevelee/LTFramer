//
//  CGAffineTransform+LTFramer.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

CGAffineTransform CGAffineTransformFromFrameToFrame(CGRect source, CGRect target)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, -source.origin.x, -source.origin.y);
    transform = CGAffineTransformScale(transform, 1.0 / source.size.width, 1.0 / source.size.height);
    transform = CGAffineTransformScale(transform, target.size.width, target.size.height);
    transform = CGAffineTransformTranslate(transform, target.origin.x, target.origin.y);
    return transform;
}
