//
//  XHUIWebViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 7/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

///< 这个控制器中的webView是UIWebView
///< 因为这个这个请求是要传cookie的, wk貌似要手动传cookie, 想来会有点麻烦, 这里先用UIWebView
class XHUIWebViewController: XHBaseViewController {
    
    var webUrl: URL?
    
    lazy var webView: UIWebView = {
        let wb = UIWebView()
        wb.backgroundColor = .white
        wb.delegate = self
        return wb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        guard let url = webUrl else {
            return
        }
        var request = URLRequest(url: url)
        var cookieDict = [String : String]()
        let cookieJar =  HTTPCookieStorage.shared
        cookieJar.cookieAcceptPolicy = .never
        var cookieHeader = [String : String]()
        if let cookies = cookieJar.cookies {
            for cookie in cookies {
                cookieDict[cookie.name] = cookie.value
            }
            var cookieString = ""
            for (k, v) in cookieDict {
                let string = String(format: "%@=%@;", k, v)
                cookieString = cookieString.appending(string)
            }
            cookieHeader["Cookie"] = cookieString
        }
        request.allHTTPHeaderFields = cookieHeader
        webView.loadRequest(request)
    }
}

// MARK: - 设置UI
extension XHUIWebViewController {
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

// MARK: - UIWebView的代理
extension XHUIWebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ///< 获取网页的标题
        title = webView.stringByEvaluatingJavaScript(from: "document.title")
        XHGlobalLoading.stopLoading()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let err = error as NSError
        ///< 错误处理
        if err.code == NSURLErrorNotConnectedToInternet {
            XHAlertHUD.showError(withStatus: "网络连接失败, 请检查网络")
        }else {
            XHAlertHUD.showError(withStatus: "加载网页失败")
        }
    }
}
