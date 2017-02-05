# LTFramer

[![CI Status](https://travis-ci.org/tevelee/LTFramer.svg?branch=master&style=flat)](https://travis-ci.org/tevelee/LTFramer)
[![Version](https://img.shields.io/cocoapods/v/LTFramer.svg?style=flat)](http://cocoapods.org/pods/LTFramer)
[![License](https://img.shields.io/cocoapods/l/LTFramer.svg?style=flat)](http://cocoapods.org/pods/LTFramer)
[![Platform](https://img.shields.io/cocoapods/p/LTFramer.svg?style=flat)](http://cocoapods.org/pods/LTFramer)

LTFramer helps defining the frames of views and layer in your layout code with a descriptive syntax.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

To install LTFramer, simply add the following line to your `Podfile`:

```ruby
pod "LTFramer"
```

then add 

```obj-c
#import <LTFramer/LTFramerKit_UIKit.h>
```

## USAGE

Normally you would describe a layout using the good old setFrame method, like this:

    double padding = 16;
    double height = 100;
    [_view setFrame:CGRectMake(padding, (self.view.frame.size.height - height) / 2.0, 	self.view.frame.size.width - 2 * padding, height)];
    
Instead, you can use LTFramer to have something simple and easily readable:
    
	[_view installFrame:^(LTFramer *framer) {
        framer.left(16).and.right(16);
        framer.alignCenterY.with.height(100);
    }];
    
You have the possibility to define relative layouts, like this:
    
    [_view installFrame:^(LTFramer *framer) {
        framer.width(50).and.height(50);
        framer.make.left.equalTo.the.right.of(_otherView).with.offset(8);
        framer.make.top.equalTo.the.same.of(_otherView);
    }];
    
Or including the Stack subspec, you have a full-featured stack view implementation ready for use:

	_stackView = [LTFramerStackView stackViewWithViews:@[_view1, _view2, _view3]];
    [_stackView setProperties:[LTFramerStackProperties configureNew:^(LTFramerStackProperties* properties) {
        [properties setSpacing:16];
        [properties setDirection:LTFramerDirectionHorizontal];
        [properties setJustification:LTFramerJustifySpaceBetween];
        [properties setAlignment:LTFramerAlignCenter];
    }]];
    [self.view addSubview:_stackView];

See the included [Example](https://github.com/tevelee/LTFramer/tree/master/Example/LTFramer) app for more.

## Author

Laszlo Teveli, tevelee@gmail.com

## License

LTFramer is available under the MIT license. See the LICENSE file for more info.
