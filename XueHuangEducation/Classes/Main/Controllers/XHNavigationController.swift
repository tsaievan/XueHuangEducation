//
//  XHNavigationController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = UIColor.Global.darkGray
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        XHGlobalLoading.stopLoading()
        ///< 取消所有网络请求
        XHNetwork.cancelAllRequest()
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        XHGlobalLoading.stopLoading()
        ///< 取消所有网络请求
        XHNetwork.cancelAllRequest()
        return super.popToRootViewController(animated: animated)
    }
}
