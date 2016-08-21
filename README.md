# LTFramer

LTFramer helps defining the frames of views and layer in your layout code with a descriptive syntax.

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
        framer.make.left.equalToThe.right.of(_otherView).with.offset(8);
        framer.make.top.equalToThe.same.of(_otherView);
    }];
    
Or including the Stack subspec, you have a full-featured stack view implementation ready for use:

	_stackView = [[LTFramerStackView stackViewWithViews:@[_view1, _view2, _view3]] configure:^(LTFramerStackView* stackView) {
        [stackView setProperties:[LTFramerStackProperties configureNew:^(LTFramerStackProperties* properties) {
            [properties setSpacing:16];
            [properties setDirection:LTFramerDirectionHorizontal];
            [properties setJustification:LTFramerJustifySpaceBetween];
            [properties setAlignment:LTFramerAlignCenter];
        }]];
        [self.view addSubview:stackView];
    }];

