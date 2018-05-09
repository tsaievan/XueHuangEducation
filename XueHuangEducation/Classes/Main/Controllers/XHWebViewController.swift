//
//  XHWebViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 26/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import WebKit

///< 这个控制器中的webView是WKWebView
class XHWebViewController: XHBaseViewController {
    
    lazy var progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.progressTintColor = UIColor.Global.skyBlue
        pv.backgroundColor = UIColor.Global.lightGray
        pv.progress = 0.0
        return pv
    }()
    
    lazy var webView: WKWebView = {
        let wb = WKWebView()
        wb.backgroundColor = .white
        wb.navigationDelegate = self;
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
        view.addSubview(progressView)
        makeConstraints()
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keypath = keyPath,
            let progress = change else {
                progressView.isHidden = true
                return
        }
        if keypath == "estimatedProgress" {
            progressView.isHidden = false
            progressView.progress = progress[.newKey] as? Float ?? 1
            if progressView.progress >= 0.9 {
                progressView.isHidden = true
            }
        }
    }
    
    fileprivate func makeConstraints() {
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.width.equalTo(XHSCreen.width)
            make.height.equalTo(2)
            make.left.equalTo(view)
            make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
        }
    }
}

// MARK: - WebView代理
extension XHWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let err = error as NSError
        ///< 错误处理
        if err.code == NSURLErrorNotConnectedToInternet {
            XHAlertHUD.showError(withStatus: "网络连接失败, 请检查网络")
        }else {
            XHAlertHUD.showError(withStatus: "加载网页失败")
        }
    }
}
