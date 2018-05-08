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

/**
 http://www.xuehuang.cn/mobileController.do?toQuestionList&courseClassId=2c92908d5c1be42b015c2dce5940000e&pCCName=%E4%B8%80%E7%BA%A7%E5%BB%BA%E9%80%A0%E5%B8%88&pCCId=ff8080815b96bc5e015b9bd171800104&actionType=my
 */

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
