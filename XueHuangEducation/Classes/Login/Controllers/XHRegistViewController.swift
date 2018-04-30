//
//  XHRegistViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 21/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHRegistViewController: XHBaseViewController {
    
    lazy var registView: XHRegistView = {
        let rv = XHRegistView()
        rv.xh_delegate = self
        return rv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension XHRegistViewController {
    fileprivate func setupUI() {
        title = "注册学习"
        view.addSubview(registView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        registView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
            make.left.bottom.right.equalTo(view)
        }
    }
}

// MARK: - XHRegistViewDelegate代理
extension XHRegistViewController: XHRegistViewDelegate {
    func registViewDidTaphaveAccountLabel(registView: XHRegistView, sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
}
