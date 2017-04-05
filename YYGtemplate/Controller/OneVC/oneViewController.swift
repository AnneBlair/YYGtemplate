//
//  oneViewController.swift
//  YYGtemplate
//
//  Created by 区块国际－yin on 2017/3/27.
//  Copyright © 2017年 blog.aiyinyu.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class oneViewController: UIViewController {
    
    var klineVC: YYGKlinecontainerVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        klineVC = YYGKlinecontainerVC(style: .noFullScreen)
        klineVC.view.frame = CGRect(x: 10, y: 200 * NOW_HEIGHT, width: UIScreeWidth - 20, height: 300 * NOW_HEIGHT)
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

    }
    @IBAction func handler(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "fullScreenSB") as? fullScreenViewController {
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}
