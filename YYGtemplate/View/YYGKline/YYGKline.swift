//
//  YYGKline.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/27.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class YYGKline: UIView {
    
    var scrollview: UIScrollView?
    
    
    init(frame: CGRect,ss: String) {
        super.init(frame: frame)
        drawFrameLayer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawFrameLayer() {
        // 交易量图    虚线
        let translatePath = UIBezierPath()
        for i in 0...14 {
            let y = height / 14 * CGFloat(i)
            translatePath.move(to: CGPoint(x: 60, y: y))
            translatePath.addLine(to: CGPoint(x: wide - 60, y: y))
        }
        let translateLayer = CAShapeLayer()
        translateLayer.lineWidth = 0.5
        translateLayer.strokeColor = UIColor(r: 240, g: 240, b: 240).cgColor
        translateLayer.fillColor = UIColor.clear.cgColor
        translateLayer.lineDashPattern = [8,8]
        translateLayer.path = translatePath.cgPath
        layer.addSublayer(translateLayer)
        
        //    |_|   线
        let sideLinePath = UIBezierPath()
        sideLinePath.move(to: CGPoint(x: 59, y: 0))
        sideLinePath.addLine(to: CGPoint(x: 59, y: height))
        
        sideLinePath.move(to: CGPoint(x: 59, y: height))
        sideLinePath.addLine(to: CGPoint(x: wide - 60, y: height))
        
        sideLinePath.move(to: CGPoint(x: wide - 60, y: 0))
        sideLinePath.addLine(to: CGPoint(x: wide - 60, y: height))
        let sideLineLayer = CAShapeLayer()
        sideLineLayer.lineWidth = 1
        sideLineLayer.strokeColor = UIColor(r: 169, g: 169, b: 169).cgColor
        sideLineLayer.path = sideLinePath.cgPath
        layer.addSublayer(sideLineLayer)
    }

}
