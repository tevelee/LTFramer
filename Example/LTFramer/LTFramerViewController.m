//
//  LTFramerViewController.m
//  LTFramer
//
//  Created by Laszlo Teveli on 08/21/2016.
//  Copyright (c) 2016 Laszlo Teveli. All rights reserved.
//

#import "LTFramerViewController.h"
#import <LTFramer/LTFramerKit_UIKit.h>
#import <LTFramer/LTFramerKit_Convenience_UIKit.h>
#import <LTFramer/LTFramerConfiguration.h>

@implementation LTFramerViewController
{
    UIView* _view1;
    UIView* _view2;
    UIView* _view3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[[LTFramerConfiguration sharedConfiguration] setHorizontallyMirrored:YES];
    
    _view1 = [UIView configureNew:^(UIView *view) {
        [view setBackgroundColor:[UIColor redColor]];
        [view addTo:self.view];
    }];
    
    _view2 = [UIView configureNew:^(UIView *view) {
        [view setBackgroundColor:[UIColor greenColor]];
        [view addTo:self.view];
    }];
    
    _view3 = [UIView configureNew:^(UIView *view) {
        [view setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2]];
        [view addTo:self.view];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_view2.skyFramer.set.width(50).and.height(50).and.alignCenter.and.then setFrame];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        [_view1 setTransform:CGAffineTransformMakeTranslation(0, 200)];
        [_view2.skyFramer.set.width(100).and.height(100).and.alignCenter.and.then setFrame];
    } completion:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_view3 installFrame:^(LTFramer *framer) {
        framer.set.paddings(UIEdgeInsetsMake(28, 8, 58, 8));
    }];
    
    [_view1 installFrame:^(LTFramer *framer) {
        framer.set.width(50).and.height(50);
        framer.set.top(36);
        framer.set.left(16);
    } ignoreTransform:YES];
}

@end
