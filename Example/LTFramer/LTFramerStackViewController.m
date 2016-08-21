//
//  LTFramerViewController.m
//  LTFramer
//
//  Created by Laszlo Teveli on 08/21/2016.
//  Copyright (c) 2016 Laszlo Teveli. All rights reserved.
//

#import "LTFramerStackViewController.h"
#import <LTFramer/LTFramerKit_UIKit.h>
#import <LTFramer/LTFramerKit_Convenience_UIKit.h>
#import <LTFramer/LTFramerKit_Stack_UIKit.h>

@implementation LTFramerStackViewController
{
    UIView* _view1;
    UIView* _view2;
    UIView* _view3;
    LTFramerStackView* _stackView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _view1 = [UILabel configureNew:^(UILabel *label) {
        [label setBackgroundColor:[UIColor redColor]];
        [label setText:@"Hello"];
        [label setTextAlignment:NSTextAlignmentCenter];
    }];
    
    _view2 = [UILabel configureNew:^(UILabel *label) {
        [label setBackgroundColor:[UIColor greenColor]];
        [label setText:@"Hi"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.stackProperties setCanGrow:@YES];
    }];
    
    _view3 = [UILabel configureNew:^(UILabel *label) {
        [label setBackgroundColor:[UIColor blueColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"Hey there"];
        [label setTextAlignment:NSTextAlignmentCenter];
    }];
    
    _stackView = [[LTFramerStackView stackViewWithViews:@[_view1, _view2, _view3]] configure:^(LTFramerStackView* stackView) {
        [stackView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2]];
        [stackView.layer setBorderWidth:1];
        [stackView.layer setCornerRadius:5];
        [stackView.layer setBorderColor:[UIColor blackColor].CGColor];
        [stackView setProperties:[LTFramerStackProperties configureNew:^(LTFramerStackProperties* properties) {
            [properties setSpacing:16];
            [properties setDirection:LTFramerDirectionHorizontal];
            [properties setJustification:LTFramerJustifySpaceBetween];
            [properties setAlignment:LTFramerAlignCenter];
        }]];
        [stackView addTo:self.view];
    }];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_stackView installFrame:^(LTFramer *framer) {
        framer.set.top(32).and.width(300).height(380).and.alignCenterX;
    }];
}

@end
