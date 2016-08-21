//
//  LTFramerVirtualBox.h
//  Pods
//
//  Created by László Teveli on 08/09/16.
//
//

#import "UIView+LTFramer.h"

typedef void(^LTFramerLayoutBlock)(CGRect frame);

@interface LTFramerVirtualBox : NSObject <LTFramerFrameSettable>

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, copy) LTFramerLayoutBlock layout;

+ (instancetype)boxWithLayout:(LTFramerLayoutBlock)layout;

@end
