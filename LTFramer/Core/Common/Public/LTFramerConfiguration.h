//
//  LTFramerConfiguration.h
//  Pods
//
//  Created by László Teveli on 2017. 02. 04..
//
//

#import <Foundation/Foundation.h>

@interface LTFramerConfiguration : NSObject

/**
 * Used when layout needs to be flipped horizontally, eg. in Arabic and Hebrew standards
 */
@property (nonatomic, assign, getter = isHorizontallyMirrored) BOOL horizontallyMirrored;

+ (instancetype)sharedConfiguration;

@end
