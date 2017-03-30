//
//  YYGlineLabel.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/29.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class YYGlineLabel: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLineLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawLineLabel() {
        let tempText = CATextLayer()
        tempText.frame = CGRect(x: 0, y: 30, width: 50, height: 20)
        tempText.string = "测试"
        tempText.fontSize = 10
        tempText.foregroundColor = UIColor.red.cgColor
        tempText.backgroundColor = UIColor.gray.cgColor
        tempText.alignmentMode = kCAAlignmentCenter
        tempText.contentsScale = UIScreen.main.scale
        layer.addSublayer(tempText)
    }
}

func getTextSize(text: String, size: CGFloat = 10) -> CGSize {
    let baseFont = UIFont.systemFont(ofSize: size)
    let size = text.size(attributes: [NSFontAttributeName: baseFont])
    let width = ceil(size.width) + 5
    let height = ceil(size.height)
    return CGSize(width: width, height: height)
}
