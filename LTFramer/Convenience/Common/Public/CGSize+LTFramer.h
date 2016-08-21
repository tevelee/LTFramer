//
//  CGSize+LTFramer.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

@import Foundation;

#undef CGSizeInfinite
#define CGSizeInfinite CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)

FOUNDATION_EXTERN CGSize CGSizeCeil(CGSize size);
FOUNDATION_EXTERN CGSize CGSizeCeilMake(CGFloat width, CGFloat height);

FOUNDATION_EXTERN CGSize CGSizeFloor(CGSize size);
FOUNDATION_EXTERN CGSize CGSizeFloorMake(CGFloat width, CGFloat height);
