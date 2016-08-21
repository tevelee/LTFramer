//
//  LTFramerStackElementPropertiesProtocol.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "LTFramerStackElementProperties.h"

@protocol LTFramerStackElement <NSObject>

@property (nonatomic, strong) LTFramerStackElementProperties* stackProperties;

@end
