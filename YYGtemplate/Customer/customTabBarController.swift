//
//  customTabBarController.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/23.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class customTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = (tabBar.items?.index(of: item))! + 1
        tabBar.subviews[index].isUserInteractionEnabled = false
        tabBar.subviews[index].pop_add(zoomAnimator(), forKey: "zoom")
        _ = delay(0.7) {
            tabBar.subviews[index].isUserInteractionEnabled = true
        }
    }
}
