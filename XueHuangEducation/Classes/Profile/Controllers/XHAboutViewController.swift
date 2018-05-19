//
//  XHAboutViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHAboutViewController: XHBaseViewController {
    
    override func viewDidLoad() {
        setupUI()
    }

}

extension XHAboutViewController {
    fileprivate func setupUI() {
        title = "关于学煌"
        view.backgroundColor = UIColor.white
    }
}
