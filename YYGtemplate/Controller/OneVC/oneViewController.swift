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
        let klineVC = YYGKlinecontainerVC(style: .noFullScreen)
        klineVC.view.frame = CGRect(x: 10, y: 200, width: 355, height: 300)
        addChildViewController(klineVC)
        view.addSubview(klineVC.view)
        klineVC.didMove(toParentViewController: self)
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "fullScreenSB") as? fullScreenViewController {
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}
