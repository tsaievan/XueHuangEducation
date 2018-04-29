//
//  XHNavigationController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = COLOR_GLOBAL_DARK_GRAY
    }
}
