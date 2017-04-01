//
//  YYGKlinecontainerVC.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/30.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum scaleStyle: Int {
    case noFullScreen
    case FullScreen
}
class YYGKlinecontainerVC: UIViewController {
    
    /// 数据
    var arrs: [Any] = []
    /// 当前的屏幕显示模式
    var scrssnStyle: scaleStyle = .noFullScreen
    
    var klineView: YYGKline!
    
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
        getDataMessage()
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
            lineFram = CGRect(x: 0, y: 0, width: view.frame.height - 20, height: view.frame.width - 60)
        }
        klineView = YYGKline(frame: lineFram, ss: "22")
        view.addSubview(klineView)
    }
    
    func getDataMessage() {
        
        let parameters: [String : Any] = ["base":["currency":"F136452704B604A2BC6D5150B05A7D18C616A200",
                                                  "issuer":"rBKc4SppocwrBQT4hXbrBqR6UcVWBLbHqc"],
                                          "counter":["currency":"BC5BFBEFF3748F1B89BB0A09893452F21B434E59",
                                                     "issuer":"rJwxNNY2H1RHr8ePY46UpJxMKUSCziYJjq"],
                                          "timeIncrement":"hour",
                                          "timeMultiple":1,
                                          "startTime":"2017-03-29T07:00:00.000Z",
                                          "endTime":"2017-04-01T07:00:00.000Z"]
        
        Alamofire.request("https://www.r8exchange.com/chart-api/offersExercised", method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                printLogDebug("success")
                if let value = response.result.value {
                    let json = JSON(value)
                    printLogDebug("\(json)")
                    self.arrs = json.arrayObject!
                    
                }
            case .failure(_):
                printLogDebug("failure")
            }
        }
    }
}
