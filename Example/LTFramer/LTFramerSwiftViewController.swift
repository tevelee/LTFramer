//
//  test.swift
//  LTFramer
//
//  Created by László Teveli on 25/09/16.
//  Copyright © 2016 Laszlo Teveli. All rights reserved.
//

import UIKit
import LTFramer

class LTFramerStackViewController : UIViewController {
    
    var view1: UIView
    
    required init?(coder aDecoder: NSCoder) {
        view1 = UIView()
        view1.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        view.addSubview(view1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view1.skyFramer.set.width(100).and.alignCenterX.then.setFrame()
    }
}
