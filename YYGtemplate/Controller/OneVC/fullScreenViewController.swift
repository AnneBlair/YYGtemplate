//
//  fullScreenViewController.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/30.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit

class fullScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let klineVC = YYGKlinecontainerVC(style: .FullScreen)
        klineVC.view.frame = view.bounds
//            CGRect(x: 10, y: 10, width: UIScreeHeight - 20, height: UIScreeWidth - 20)
        addChildViewController(klineVC)
        view.addSubview(klineVC.view)
        klineVC.didMove(toParentViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }

    @IBAction func touchHandler(_ sender: UIButton) {
        modalTransitionStyle = .crossDissolve
        dismiss(animated: true, completion: nil)
    }
}
