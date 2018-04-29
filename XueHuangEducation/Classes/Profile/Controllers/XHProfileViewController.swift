//
//  XHProfileViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHProfileViewController: XHBaseViewController {
    
    lazy var profileView: XHProfileView = {
        let pv = XHProfileView()
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = COLOR_HOMEPAGE_BACKGROUND
        setupUI()
    }
}

// MARK: - 设置UI
extension XHProfileViewController {
    fileprivate func setupUI() {
        view.addSubview(profileView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}
