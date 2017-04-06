//
//  KlineWalkView.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/31.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit
import SwiftyJSON

class KlineWalkView: UIView {
    
    var parametric = KlineParameter()
    var kDataArr: [JSON] = []
    /// 柱状图
    var columnLayer = YYGShapeLayer()
    var textLayer = YYGShapeLayer()
    var bottomLayer = YYGShapeLayer()
    /// 放大系数
    var ratio: CGFloat = 1
    /// 间距之间显示的个数
    var scaleNum: Int = 3
    /// 底部标注宽度
    var spaceScale: CGFloat {
        let textSize = "3月/23".getStringSzie()
        return textSize.width * ratio
    }
    
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
            if let arr = dic["Kdata"] {
                kDataArr = arr as! [JSON]
            }
            drawKlineView()
            // 数据更新的时候从新绘制底部
            drawBottomScale()
            drawTradingVolum()
        }
    }
    
    /// Trading volume
    func drawKlineView() {
        clearLayer()
        
    }
    
    func clearLayer() {

    }
    
    /// 蜡烛图
    private func drawCandleChartLayer() {
        
    }
    
    /// 交易量柱状图
    private func drawTradingVolum() {
        columnLayer.removeFromSuperlayer()
        columnLayer.sublayers?.removeAll()
        // 3个
        let unit = spaceScale / 15
        for i in 1..<kDataArr.count {
            rectCalculate(i: i, unit: unit)
        }
        layer.addSublayer(columnLayer)
    }
    func rectCalculate(i: Int,unit: CGFloat) {
    
        let volume: CGFloat = CGFloat(kDataArr[i][1].doubleValue) / 30000.0
        let h = volume * (height - 45) / 11.0
        let rect = CGRect(x: CGFloat(i) * spaceScale / 3 + unit , y: height - 30 - h, width: unit * 3, height: h)
        let linePath = UIBezierPath(rect: rect)
        let vlayer = YYGShapeLayer()
        vlayer.path = linePath.cgPath
        vlayer.lineWidth = 0.5
        vlayer.fillColor = UIColor.white.cgColor
        vlayer.strokeColor = UIColor(r: 196, g: 196, b: 196).cgColor
        
        columnLayer.addSublayer(vlayer)
        
//        kDataArr[i + 1][1].floatValue / 1000.0 / 30 * (height - 45) / 11.0
    }
    
    func getVolumeLayer(i: Int) -> YYGShapeLayer {
        let path = UIBezierPath()
        let vlayer = YYGShapeLayer()
        vlayer.path = path.cgPath
        return vlayer
    }
    
    /// 此处后期可以优化
    func drawBottomScale() {
        textLayer.removeFromSuperlayer()
        bottomLayer.removeFromSuperlayer()
        bottomLayer.sublayers?.removeAll()
        textLayer.sublayers?.removeAll()
        let textSize = "3月/23".getStringSzie()
        let bottomScale = UIBezierPath()
        for i in 1..<(kDataArr.count / scaleNum) {
            let coordX = CGFloat(i) * spaceScale
            bottomScale.move(to: CGPoint(x: coordX, y: height - 30))
            bottomScale.addLine(to: CGPoint(x: coordX, y: height - 26))
            let textBottom = CATextLayer()
            textBottom.string = datePatternSetting(i: i)
            textBottom.frame = CGRect(origin: CGPoint(x: coordX - spaceScale / 2, y: height - 24), size: textSize)
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
    private var lastStr: String = ""
    
    func datePatternSetting(i: Int) -> String {
        let str = kDataArr[i * scaleNum][0].stringValue
        // 显示月份
        if lastStr != str.stringCut(end: 10) {
            let dispose = isSameDay(str: str)
            lastStr = str.stringCut(end: 10)
            return dispose
        }
        // 不显示月份
        return ""
    }
    
    func isSameDay(str: String) -> String {
        let arr = str.stringToArr()
        var tempStr = ""
        if arr[5] != "0" {
            tempStr += arr[5]
        }
        tempStr = tempStr + arr[6] + "月/" + arr[8] + arr[9]
        return tempStr
    }
}
