//
//  XHShowThemeWebController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 7/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

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
        if (url.absoluteString as NSString).contains("mobilePaperCatalog") {
            navigationController?.popViewController(animated: true)
            return false
        }
        return super.webView(webView, shouldStartLoadWith: request, navigationType: navigationType)
    }
}
