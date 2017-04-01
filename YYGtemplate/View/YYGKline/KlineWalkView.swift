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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Trading volume
    func drawKlineView() {
        drawTradingVolum()
        drawBootomScale()
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
    
    func drawBootomScale() {
        
    }
}
