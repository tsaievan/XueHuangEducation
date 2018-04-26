//
//  XHShowNetCourseViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 26/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHShowNetCourseViewController: XHWebViewController {
    
    var videoUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = videoUrl else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
