//
//  LTFramerVirtualBox.h
//  Pods
//
//  Created by László Teveli on 08/09/16.
//
//

#import "LTFramerStackElementProperties.h"
#import "LTFramerStackProperties.h"
#import "LTFramerStackSubject.h"

@interface LTFramerStack : NSObject <LTFramerSizeFittable>

@property (nonatomic, strong) NSArray<LTFramerStackSubject>* subjects;
@property (nonatomic, strong) NSValue* boundingSize;
@property (nonatomic, strong) LTFramerStackProperties* properties;

+ (instancetype)stackWithSubjects:(NSArray<LTFramerStackSubject>*)subjects;

- (void)prepareFrames;
- (CGRect)determineFrameForSubject:(LTFramerStackSubject)subject;

@end
