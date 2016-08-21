//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import LTFramer

let view1 = UIView(frame: .zero)
let view2 = UIView(frame: .zero)
let view3 = UIView(frame: .zero)

let stack = LTFramerStackView()
stack.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
stack.subjects = [view1, view2, view3]
stack.properties.alignment = .SpaceBetween

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
page.liveView = stack

//: [Next](@next)
