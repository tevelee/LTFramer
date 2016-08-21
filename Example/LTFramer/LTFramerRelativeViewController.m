//
//  LTFramerViewController.m
//  LTFramer
//
//  Created by Laszlo Teveli on 08/21/2016.
//  Copyright (c) 2016 Laszlo Teveli. All rights reserved.
//

#import "LTFramerRelativeViewController.h"
#import <LTFramer/LTFramerKit_UIKit.h>
#import <LTFramer/LTFramerKit_Convenience_UIKit.h>

@implementation LTFramerRelativeViewController
{
    UIView* _view1;
    UIView* _view2;
    UIView* _view3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _view1 = [UIView configureNew:^(UIView *view) {
        [view setBackgroundColor:[UIColor redColor]];
        [view addTo:self.view];
    }];
    
    _view2 = [UIView configureNew:^(UIView *view) {
        [view setBackgroundColor:[UIColor greenColor]];
        [view addTo:self.view];
    }];
    
    _view3 = [UIView configureNew:^(UIView *view) {
        [view setBackgroundColor:[UIColor blueColor]];
        [view addTo:self.view];
    }];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [_view1 installFrame:^(LTFramer *framer) {
        framer.set.top(28).and.alignCenterX;
        framer.set.width(80).and.height(40);
    } inRelativeContainer:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    
    [_view2 installFrame:^(LTFramer *framer) {
        framer.set.width(50).with.priority(1);
        framer.make.left.equalTo.the.right.of(_view1).with.offset(8).and.priority(1);
        framer.make.top.equalTo.the.same.of(_view1);
        framer.make.height.equalTo.value(50);
    }];
    
    [_view3 installFrame:^(LTFramer *framer) {
        framer.set.height(30);
        framer.make.left.equalTo.the.left.of(_view1);
        framer.make.right.equalTo.the.right.of(_view2);
        framer.make.top.equalTo.the.bottom.of(_view2).with.offset(8);
    }];
}

@end
