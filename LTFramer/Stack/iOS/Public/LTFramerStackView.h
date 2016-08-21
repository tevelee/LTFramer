//
//  LTFramerStackView.h
//  Pods
//
//  Created by László Teveli on 16/09/16.
//
//

#import "LTFramerStack.h"

@interface LTFramerStackView : UIView

@property (nonatomic, strong, readonly) LTFramerStack* stack;
@property (nonatomic, strong) LTFramerStackProperties* properties;

+ (instancetype)stackViewWithViews:(NSArray<UIView*>*)subjects;
- (instancetype)initWithViews:(NSArray<UIView*>*)subjects;

- (void)addArrangedSubview:(UIView *)view;
- (void)removeArrangedSubview:(UIView *)view;
- (void)insertArrangedSubview:(UIView *)view atIndex:(NSUInteger)stackIndex;

@end
