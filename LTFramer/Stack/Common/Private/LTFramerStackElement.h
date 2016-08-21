//
//  LTFramerStackElement.h
//  Pods
//
//  Created by László Teveli on 15/09/16.
//
//

#import "LTFramerStackElementProperties.h"
#import "LTFramerSizeFittableProtocol.h"
#import "LTFramerStackSubject.h"
#import "LTFramerStackAlignment.h"

struct LTFramerRange {
    double min;
    double max;
};
typedef struct LTFramerRange LTFramerRange;

FOUNDATION_EXTERN LTFramerRange LTFramerRangeMake(double min, double max);

@interface LTFramerStackElement : NSObject

@property (nonatomic, strong, readonly) NSString* identifier;
@property (nonatomic, strong) LTFramerStackSubject subject;

@property (nonatomic, assign) LTFramerStackAlignment alignment;
@property (nonatomic, assign) LTFramerRange sizeRange;
@property (nonatomic, assign) NSInteger priority;

@end
