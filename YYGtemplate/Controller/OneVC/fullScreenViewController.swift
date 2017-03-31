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
        
        let tempView = UIView(frame: CGRect(x: 10, y: 50, width: UIScreeHeight - 20, height: UIScreeWidth - 50))
        view.addSubview(tempView)
        let klineVC = YYGKlinecontainerVC(style: .FullScreen)
        klineVC.view.frame = CGRect(x: 0, y: 0, width: UIScreeHeight - 20 , height: UIScreeWidth - 50)
        addChildViewController(klineVC)
        tempView.addSubview(klineVC.view)
        klineVC.didMove(toParentViewController: self)
        
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
