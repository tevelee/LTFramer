import UIKit
import PlaygroundSupport
import LTFramer

let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
let view = UIView(frame: .zero)
container.addSubview(view)

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
page.liveView = container

view.skyFramer.resetRules()
view.skyFramer.top(5).right(10).width(50).and.height(25).computedFrame()
view.skyFramer.resetRules()
view.skyFramer.paddings(UIEdgeInsets(top: 8,left: 8,bottom: 8,right: 8)).computedFrame()
view.skyFramer.resetRules()
view.skyFramer.alignCenter.with.size(CGSize(width: 50, height: 50)).computedFrame()

//: [Next](@next)