//
//  XHHomePageViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHHomePageViewController: XHBaseViewController {
    
    
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension XHHomePageViewController {
    fileprivate func setupUI() {
        self.navigationItem.title = "学煌教育网"
        self.view.backgroundColor = .white
    }
}
