//
//  XHShowThemeWebController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 7/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension String {
    struct ShowThemeWebController {
        static let mobilePaperCatalog = "mobilePaperCatalog"
    }
}

class XHShowThemeWebController: XHUIWebViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension XHShowThemeWebController {
    override func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return false
        }
        ///< 当url中包含`mobilePaperCatalog`字段时, 禁用跳转, 并且调用pop函数返回上一个控制器
        if (url.absoluteString as NSString).contains(String.ShowThemeWebController.mobilePaperCatalog) {
            navigationController?.popViewController(animated: true)
            return false
        }
        return super.webView(webView, shouldStartLoadWith: request, navigationType: navigationType)
    }
}
