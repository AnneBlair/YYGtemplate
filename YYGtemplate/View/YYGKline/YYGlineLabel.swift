//
//  YYGlineLabel.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/29.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class YYGlineLabel: UIView {
    
    /// 所有虚线的X
    var lineX: CGFloat = 45
    /// 最上面开始的Y
    var lineY: CGFloat = 15
    /// 虚线的个数
    var dottedNum = 11
    /// K线的坐标系的y
    var lineHeight: CGFloat {
        return height - lineY * 2
    }
    /// 标尺的宽度
    var scaleWide: CGFloat = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLineLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }

    func drawLineLabel() {
        
        let textSize = "100K".getStringSzie()
        let textX = lineX - textSize.width - scaleWide - 2
        for i in 0...dottedNum {
            do {
                let tempText = CATextLayer()
                textSetting(textLayer: tempText)
                let y = ((lineHeight - lineY) / CGFloat(dottedNum)) * CGFloat(i) + lineY - (textSize.height / 2)
                tempText.string = "\(30 * (dottedNum - i))K"
                tempText.frame = CGRect(origin: CGPoint(x: textX, y: y), size: textSize)
                layer.addSublayer(tempText)
            }
            do {
                let textX = wide - lineX + scaleWide + 2
                let tempText = CATextLayer()
                textSetting(textLayer: tempText)
                tempText.alignmentMode = kCAAlignmentLeft
                let y = ((lineHeight - lineY) / CGFloat(dottedNum)) * CGFloat(i) + lineY - (textSize.height / 2)
                tempText.string = "\(Double(66 + (dottedNum - i)) / 10.0)"
                tempText.frame = CGRect(origin: CGPoint(x: textX, y: y), size: textSize)
                layer.addSublayer(tempText)
            }
        }
    }
    func textSetting(textLayer: CATextLayer) {
        textLayer.fontSize = 10
        textLayer.foregroundColor = UIColor.red.cgColor
        textLayer.alignmentMode = kCAAlignmentRight
        textLayer.contentsScale = UIScreen.main.scale
    }
}


