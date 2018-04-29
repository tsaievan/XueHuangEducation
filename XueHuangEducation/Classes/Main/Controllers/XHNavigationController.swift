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
        self.navigationBar.barTintColor = COLOR_GLOBAL_DARK_GRAY
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        return super.popToViewController(viewController, animated: true)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if let viewController = super.popViewController(animated: animated) {
            let clsName = (Bundle.bundleName ?? "") + "." + "XHPlayNetCourseViewController"
            guard let cls = NSClassFromString(clsName) else {
                return super.popViewController(animated: animated)
            }
            if viewController.isKind(of: cls) {
                viewController.navigationItem.rightBarButtonItem?.title = "全屏"
                if let appdelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    appdelegate.allowRotation = false
                }
                return super.popViewController(animated: animated)
            }
        }
        return super.popViewController(animated: animated)
    }
}
