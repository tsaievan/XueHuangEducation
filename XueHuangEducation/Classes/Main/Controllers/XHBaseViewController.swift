//
//  XHBaseViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import MJRefresh

class XHBaseViewController: UIViewController {
    
    ///< 页面消失的时候, 去掉AlertHUD
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if XHAlertHUD.isVisible() {
            XHAlertHUD.dismiss()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///< 让返回按钮没有标题的方法
        let backItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backItem
    }
}


