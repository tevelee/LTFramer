//
//  LTFramer.h
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import <Foundation/Foundation.h>
#import "LTFramerRule.h"
#import "LTFramerFrameSettableProtocol.h"
#import "LTFramerProtocol.h"

@interface LTFramer : NSObject <LTFramer>

+ (_Nonnull instancetype)framerWithSubject:(_Nonnull LTFramerSubject)subject boundingSize:(CGSize)size;

- (void)resetRules;
- (void)addRule:(LTFramerRule* _Nonnull)rule;
- (NSArray<LTFramerRule*>* _Nonnull)allRules;

@end
