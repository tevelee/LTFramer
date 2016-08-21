//
//  LTFramerStackSubject.h
//  Pods
//
//  Created by László Teveli on 17/09/16.
//
//

#import "LTFramerFrameSettableProtocol.h"
#import "LTFramerSizeFittableProtocol.h"
#import "LTFramerStackElementProtocol.h"

typedef id<LTFramerFrameSettable, LTFramerStackElement, LTFramerSizeFittable> LTFramerStackSubject;
