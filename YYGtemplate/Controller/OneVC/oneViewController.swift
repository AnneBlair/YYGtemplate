//
//  oneViewController.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/27.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class oneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let klineView = YYGKline(frame: CGRect(x: 0, y: 200, width: 375, height: 300), ss: "22")
//        klineView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(klineView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
