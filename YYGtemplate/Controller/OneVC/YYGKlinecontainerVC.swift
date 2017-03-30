//
//  YYGKlinecontainerVC.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/30.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

enum scaleStyle: Int {
    case noFullScreen
    case FullScreen
}
class YYGKlinecontainerVC: UIViewController {

    var scrssnStyle: scaleStyle = .noFullScreen
    init(style: scaleStyle) {
        scrssnStyle = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpViewController() {
        var lineFram = CGRect.zero
        switch scrssnStyle {
        case .noFullScreen:
            lineFram = CGRect(x: 0, y: 0, width: 355, height: 300)
        case .FullScreen:
            lineFram = CGRect(x: 0, y: 50, width: view.frame.height, height: view.frame.width - 50)
        }
        let klineView = YYGKline(frame: lineFram, ss: "22")
        view.addSubview(klineView)
    }
}
