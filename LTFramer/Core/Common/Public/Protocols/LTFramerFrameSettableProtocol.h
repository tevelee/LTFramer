//
//  LTFramerFrameSettable.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "LTFramerFrameGettableProtocol.h"

@protocol LTFramerFrameSettable <LTFramerFrameGettable>

- (void)setFrame:(CGRect)frame;

@end
