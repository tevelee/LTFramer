//
//  UIView+LTFramer.h
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import <UIKit/UIKit.h>
#import "LTFramer.h"
#import "LTFramerFrameInstallableProtocol.h"
#import "LTFramerSizeFittableProtocol.h"

@interface UIView (LTFramer_BlockConvenience) <LTFramerFrameSettable, LTFramerFrameInstallable, LTFramerSizeFittable>

@property (nonatomic, nonnull, readonly) LTFramer* skyFramer;

@end
