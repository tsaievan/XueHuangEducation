//
//  XHShowThemeWebController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 7/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHShowThemeWebController: XHUIWebViewController {
    
    var webUrl: URL?

    ///< http://www.xuehuang.cn/mobileController.do?mobilePaperQuestion&paperCatalogId=2c92908d5c2f6c9b015c32d5e0980884&paperId=2c92908d5c2f6c9b015c32c9c8920841&isJj=0&isViewAnswer=0
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = webUrl else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}
