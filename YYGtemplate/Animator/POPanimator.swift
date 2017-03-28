//
//  POPanimator.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/23.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit
import pop

public func buttonLimit(_ sender: UIButton) {
    sender.isUserInteractionEnabled = false
    sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    _ = delay(0.7) {
        sender.isUserInteractionEnabled = true
        sender.pop_add(zoomAnimator(), forKey: "zoomAnimator")
        sender.backgroundColor = UIColor(hex: 0x0F88EB)
    }
}
public func zoomAnimator() -> POPSpringAnimation {
    let animal = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    animal?.velocity = NSValue(cgPoint: CGPoint(x: 10, y: 10))
    printLogDebug(animal?.isPaused)
    //    animal?.removedOnCompletion = false
    animal?.springBounciness = 20
    return animal!
}

public func noAnimator() -> POPSpringAnimation {
    let noAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
    noAnimation?.velocity = (2000)
    noAnimation?.springBounciness = 20
    return noAnimation!
}
