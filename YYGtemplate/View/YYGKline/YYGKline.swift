//
//  YYGKline.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/27.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//  RWu1y6mo

import UIKit

class YYGKline: UIView {
    
    /// 所有虚线的X
    var lineX: CGFloat = 45
    /// 最上面开始的Y
    var lineY: CGFloat = 15
    /// 虚线的个数
    var dottedNum = 11
    /// K线的高度
    var lineHeight: CGFloat {
        return height - lineY * 2
    }
    /// 标尺的宽度
    var scaleWide: CGFloat = 6
    
    var scrollview: UIScrollView?
    
    init(frame: CGRect,ss: String) {
        super.init(frame: frame)
        drawFrameLayer()
        let label = YYGlineLabel(frame: bounds)
        addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawFrameLayer() {
        /// 边框线
        let boundsLinePath = UIBezierPath(rect: bounds)
        let boundLineLayer = CAShapeLayer()
        boundLineLayer.lineWidth = 0.5
        boundLineLayer.strokeColor = UIColor(r: 240, g: 240, b: 240).cgColor
        boundLineLayer.path = boundsLinePath.cgPath
        boundLineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(boundLineLayer)
        
        // 交易量图    虚线
        let translatePath = UIBezierPath()
        /// 标注尺
        let scalePlatePath = UIBezierPath()
        for i in 0..<dottedNum {
            let y = ((lineHeight - lineY) / CGFloat(dottedNum)) * CGFloat(i) + lineY
            translatePath.move(to: CGPoint(x: lineX, y: y))
            translatePath.addLine(to: CGPoint(x: wide - lineX, y: y))
            
            scalePlatePath.move(to: CGPoint(x: lineX - scaleWide, y: y))
            scalePlatePath.addLine(to: CGPoint(x: lineX, y: y))
            
            scalePlatePath.move(to: CGPoint(x: wide - lineX, y: y))
            scalePlatePath.addLine(to: CGPoint(x: wide - lineX + scaleWide, y: y))
        }
        let translateLayer = CAShapeLayer()
        translateLayer.lineWidth = 0.5
        translateLayer.strokeColor = UIColor(r: 240, g: 240, b: 240).cgColor
        translateLayer.fillColor = UIColor.clear.cgColor
        translateLayer.lineDashPattern = [6,6]
        translateLayer.path = translatePath.cgPath
        layer.addSublayer(translateLayer)
        
        let scalePlateLayer = CAShapeLayer()
        scalePlateLayer.strokeColor = UIColor(r: 221, g: 221, b: 221).cgColor
        scalePlateLayer.path = scalePlatePath.cgPath
        layer.addSublayer(scalePlateLayer)
        
        //    |_|   线
        let sideLinePath = UIBezierPath()
        sideLinePath.move(to: CGPoint(x: lineX, y: lineY))
        sideLinePath.addLine(to: CGPoint(x: lineX, y: lineHeight))
        //    _
        sideLinePath.move(to: CGPoint(x: lineX, y: lineHeight))
        sideLinePath.addLine(to: CGPoint(x: wide - lineX, y: lineHeight))
        //    |
        sideLinePath.move(to: CGPoint(x: wide - lineX, y: lineY))
        sideLinePath.addLine(to: CGPoint(x: wide - lineX, y: lineHeight))
        let sideLineLayer = CAShapeLayer()
        sideLineLayer.lineWidth = 1
        sideLineLayer.strokeColor = UIColor(r: 212, g: 212, b: 212).cgColor
        sideLineLayer.path = sideLinePath.cgPath
        layer.addSublayer(sideLineLayer)
    }
}

