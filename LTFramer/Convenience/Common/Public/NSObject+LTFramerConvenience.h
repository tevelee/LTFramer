//
//  NSObject+LTFramerConvenience.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import <Foundation/Foundation.h>

typedef void(^LTFramerConfigureBlock)(_Nonnull id object);

@interface NSObject (LTFramerConvenience)

+ (_Nonnull instancetype)configureNew:(_Nonnull LTFramerConfigureBlock)block;
- (_Nonnull instancetype)configure:(_Nonnull LTFramerConfigureBlock)block;

@end
