//
//  XHWebViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 26/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import WebKit

class XHWebViewController: XHBaseViewController {
    
    lazy var webView: WKWebView = {
        let wb = WKWebView()
        return wb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - 设置UI
extension XHWebViewController {
    fileprivate func setupUI() {
        view.addSubview(webView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}
