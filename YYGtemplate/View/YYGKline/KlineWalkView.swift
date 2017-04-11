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
    /// 蜡烛图
    var candleLayer = YYGShapeLayer()
    /// 柱状图
    var columnLayer = YYGShapeLayer()
    /// 底部文字
    var textLayer = YYGShapeLayer()
    /// 底部标尺
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
                drawKlineView()
                // 数据更新的时候从新绘制底部
                drawBottomScale()
                drawTradingVolum()
                drawCandleChartLayer()
            }
        }
    }
    
    /// Trading volume
    func drawKlineView() {
        clearLayer()
    }
    
    func clearLayer() {

    }
    func loopArrCount(loop :(_ i: Int)-> Void) {
        for i in 1..<kDataArr.count {
            loop(i)
        }
    }
    /// 蜡烛图
    private func drawCandleChartLayer() {
        candleLayer.removeFromSuperlayer()
        candleLayer.sublayers?.removeAll()
        loopArrCount() { i in
            singleCandleLayer(i: i)
        }
        layer.addSublayer(candleLayer)
    }
    
    func singleCandleLayer(i: Int) {

        let rect = rectForSingleCandle(i: i)
        let candelBezier = UIBezierPath(rect: rect)
        drawSingleHatch(i: i, candelPath: candelBezier)
        let cLayer = YYGShapeLayer()
        cLayer.path = candelBezier.cgPath
        cLayer.strokeColor = UIColor.black.cgColor
        openAndCloseCompare(i: i) { isOpen in
            if isOpen {
                cLayer.fillColor = UIColor(r: 10, g: 143, b: 54).cgColor
            } else {
                cLayer.fillColor = UIColor.red.cgColor
            }
        }
        candelBezier.lineWidth = 0.5
        candleLayer.addSublayer(cLayer)
    }
    /// 单个影线
    ///
    /// - Parameters:
    ///   - i: 第几个
    ///   - candelPath: 画线的对象
    func drawSingleHatch(i: Int,candelPath: UIBezierPath) {
        let heightPrice = kDataArr[i][5].doubleValue
        let lowPrice = kDataArr[i][6].doubleValue
        let unit = spaceScale / 15 - 0.5
        let pathX = CGFloat(i) * spaceScale / 3 + unit * 2.5
        let coordH: CGFloat = priceToCoordY(price: Float(heightPrice))
        let coorhH = priceToCoordY(price: Float(lowPrice))
        candelPath.move(to: CGPoint(x: pathX, y: height - 30 - coordH))
        candelPath.addLine(to: CGPoint(x: pathX, y: height - coorhH - 30))
    }
    /// 价钱转换为高度
    ///
    /// - Parameter price: 价格
    /// - Returns: 高度
    func priceToCoordY(price: Float) -> CGFloat {
        let priceParmaeter: CGFloat = CGFloat((price - 6.6) * 10)
        let coordY = priceParmaeter * (height - 45) / 11.0
        return coordY
    }
    
    func rectForSingleCandle(i: Int) -> CGRect {
        
        let openingPrice: Float = Float(kDataArr[i][4].stringValue)!
        let closePrice: Float = Float(kDataArr[i][7].stringValue)!
        var coordHh: CGFloat = 0
        var coordH: CGFloat = 0
        openAndCloseCompare(i: i) { isOpen in
            if isOpen {
                coordHh = priceToCoordY(price: openingPrice) - priceToCoordY(price: closePrice)
                coordH = priceToCoordY(price: openingPrice)
            } else {
                coordHh = priceToCoordY(price: closePrice) - priceToCoordY(price: openingPrice)
                coordH = priceToCoordY(price: closePrice)
            }
        }
        let unit = spaceScale / 15 - 0.5
        let rect = CGRect(x: CGFloat(i) * spaceScale / 3 + unit, y: height - 30 - coordH, width: unit * 3, height: coordHh)
        return rect
    }
    
    func openAndCloseCompare(i: Int,result: (_ isOpen: Bool)-> Void) {
        let openingPrice: Float = Float(kDataArr[i][4].stringValue)!
        let closePrice: Float = Float(kDataArr[i][7].stringValue)!
        let bool = openingPrice > closePrice ? true : false
        result(bool)
    }

    /// 交易量柱状图
    private func drawTradingVolum() {
        columnLayer.removeFromSuperlayer()
        columnLayer.sublayers?.removeAll()
        // 3个
        let unit = spaceScale / 15
        loopArrCount() { i in
            rectCalculate(i: i, unit: unit)
        }
        layer.addSublayer(columnLayer)
    }
    
    /// 单个柱状图处理
    ///
    /// - Parameters:
    ///   - i: 第几个
    ///   - unit: 最小间距份数
    func rectCalculate(i: Int,unit: CGFloat) {
        let volume: CGFloat = CGFloat(kDataArr[i][1].doubleValue) / 30000.0
        let h = volume * (height - 45) / 11.0
        let rect = CGRect(x: CGFloat(i) * spaceScale / 3 + unit , y: height - 30 - h, width: unit * 3, height: h)
        let linePath = UIBezierPath(rect: rect)
        let vlayer = YYGShapeLayer()
        vlayer.path = linePath.cgPath
        vlayer.lineWidth = 0.5
        vlayer.fillColor = UIColor(r: 233, g: 233, b: 233).cgColor
        vlayer.strokeColor = UIColor(r: 196, g: 196, b: 196).cgColor
        columnLayer.addSublayer(vlayer)
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
            textBottomSetting(i: i, coordX: coordX, textSize: textSize)
        }
        let bottomCashape = CAShapeLayer()
        bottomCashape.lineWidth = 1
        bottomCashape.strokeColor = UIColor(r: 221, g: 221, b: 221).cgColor
        bottomCashape.path = bottomScale.cgPath
        bottomLayer.addSublayer(bottomCashape)
        
        layer.addSublayer(bottomLayer)
        layer.addSublayer(textLayer)
    }
    
    /// 每个底部标注
    ///
    /// - Parameters:
    ///   - i: 第几个
    ///   - coordX: x坐标
    ///   - textSize: 字体大小
    func textBottomSetting(i: Int,coordX: CGFloat,textSize: CGSize) {
        let textBottom = CATextLayer()
        textBottom.string = datePatternSetting(i: i)
        textBottom.frame = CGRect(origin: CGPoint(x: coordX - spaceScale / 2, y: height - 24), size: textSize)
        textBottom.fontSize = 9
        textBottom.foregroundColor = UIColor.red.cgColor
        textBottom.alignmentMode = kCAAlignmentCenter
        textBottom.contentsScale = UIScreen.main.scale
        textLayer.addSublayer(textBottom)
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
