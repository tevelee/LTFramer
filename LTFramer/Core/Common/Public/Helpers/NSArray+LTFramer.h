//
//  NSArray+LTFramer.h
//  Pods
//
//  Created by László Teveli on 21/08/16.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (LTFramerFunctional)

- (NSArray*)skyFramer_map:(id(^)(id object))block;
- (NSArray*)skyFramer_filter:(BOOL(^)(id object))block;

- (NSArray*)skyFramer_while:(BOOL(^)(id object))block;
- (NSArray*)skyFramer_until:(BOOL(^)(id object))block;

- (NSDictionary*)skyFramer_dictionaryUsingKey:(id<NSCopying>(^)(id object))block;

- (id)skyFramer_aggregateWithInitial:(id)initial block:(id(^)(id rolling, id current))block;

- (double)skyFramer_sum:(double(^)(id object))block;
- (double)skyFramer_max:(double(^)(id object))block;
- (double)skyFramer_min:(double(^)(id object))block;

- (BOOL)skyFramer_if:(BOOL(^)(id object))block;
- (id)skyFramer_first:(BOOL(^)(id object))block;

- (void)skyFramer_forEach:(void(^)(id object))block;

@end
