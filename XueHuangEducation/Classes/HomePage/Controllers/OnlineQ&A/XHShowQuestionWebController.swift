//
//  XHShowQuestionWebController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 8/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHShowQuestionWebController: XHUIWebViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension XHShowQuestionWebController {
    override func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return false
        }
        if (url.absoluteString as NSString).contains("toCourseCatalog") {
            navigationController?.popViewController(animated: true)
            return false
        }
        return super.webView(webView, shouldStartLoadWith: request, navigationType: navigationType)
    }
}
