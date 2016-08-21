//
//  LTFramerConfiguration.m
//  Pods
//
//  Created by László Teveli on 2017. 02. 04..
//
//

#import "LTFramerConfiguration.h"

@implementation LTFramerConfiguration

+ (instancetype)sharedConfiguration
{
    static LTFramerConfiguration* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LTFramerConfiguration alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.horizontallyMirrored = NO;
    }
    return self;
}

@end
