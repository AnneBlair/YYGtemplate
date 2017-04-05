//
//  KlineWalkView.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/31.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class KlineWalkView: UIView {
    
    var parametric = KlineParameter()
    var kDataArr: [Any] = []
    var columnLayer = YYGShapeLayer()
    var textLayer = YYGShapeLayer()
    var bottomLayer = YYGShapeLayer()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(kdataNotification(kNotifi:)), name: NSNotification.Name(rawValue: "Kdata"), object: nil)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func kdataNotification(kNotifi: Notification) {
        if let dic = kNotifi.userInfo {
            kDataArr = dic["Kdata"] as! [Any]
            drawKlineView()
        }
    }
    
    /// Trading volume
    func drawKlineView() {
        clearLayer()
        drawTradingVolum()
        drawBottomScale()
    }
    
    func clearLayer() {
        textLayer.removeFromSuperlayer()
        bottomLayer.removeFromSuperlayer()
    }
    
    /// 蜡烛图
    private func drawCandleChartLayer() {
        
    }
    
    /// 交易量柱状图
    private func drawTradingVolum() {
        let linePath = UIBezierPath(rect: CGRect(x: parametric.lineX + 3, y: height - 80, width: 2, height: 50))
        let vlayer = YYGShapeLayer()
        vlayer.path = linePath.cgPath
        vlayer.lineWidth = 0.5
        vlayer.fillColor = UIColor.white.cgColor
        vlayer.strokeColor = UIColor(r: 196, g: 196, b: 196).cgColor
        layer.addSublayer(vlayer)
    }
    
    func drawBottomScale() {
        bottomLayer.sublayers?.removeAll()
        textLayer.sublayers?.removeAll()
        
        let bottomScale = UIBezierPath()
        let textSize = "3月/23".getStringSzie()
        let spaceScale = textSize.width
        let countNum = Int(wide / spaceScale)
        for i in 0..<countNum {
            let x = CGFloat(i) * spaceScale
            bottomScale.move(to: CGPoint(x: x, y: height - 30))
            bottomScale.addLine(to: CGPoint(x: x, y: height - 26))
            
            let textBottom = CATextLayer()
            textBottom.string = "3月/22"
            textBottom.frame = CGRect(origin: CGPoint(x: x - spaceScale / 2, y: height - 24), size: textSize)
            textSetting(textLayer: textBottom)
            textLayer.addSublayer(textBottom)
        }
        let bottomCashape = CAShapeLayer()
        bottomCashape.lineWidth = 1
        bottomCashape.strokeColor = UIColor(r: 221, g: 221, b: 221).cgColor
        bottomCashape.path = bottomScale.cgPath
        bottomLayer.addSublayer(bottomCashape)
        
        layer.addSublayer(bottomLayer)
        layer.addSublayer(textLayer)
    }
    
    func textSetting(textLayer: CATextLayer) {
        textLayer.fontSize = 9
        textLayer.foregroundColor = UIColor.red.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
    }
    
//    "2017-03-29T07:00:00+00:00"
    func datePatternSetting(str: String) -> String {
        var processStr = str
        var chat = processStr[processStr.index(processStr.startIndex, offsetBy: 5)]
        return ""
    }
    
    
    
    
    
}
