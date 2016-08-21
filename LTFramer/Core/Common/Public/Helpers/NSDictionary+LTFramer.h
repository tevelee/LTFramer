//
//  NSDictionary+LTFramer.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LTFramer)

- (NSDictionary*)skyFramer_map:(id(^)(id<NSObject> key, id object))block;
- (NSDictionary*)skyFramer_filter:(BOOL(^)(id<NSObject> key, id object))block;

@end
