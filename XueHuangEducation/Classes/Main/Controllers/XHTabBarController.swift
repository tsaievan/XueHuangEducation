//
//  XHTabBarController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: - 设置UI
extension XHTabBarController {
    
    fileprivate func setupUI() {
        self.delegate = self
        tabBar.backgroundColor = .white
        ///< 设置tabBar的底色为纯白, 没有半透明效果
        tabBar.barTintColor = .white
        ///< 将barStyle修改成black模式, tabBar上面那条黑线就看不到了
        tabBar.barStyle = .black
        tabBar.tintColor = COLOR_GLOBAL_BLUE
        addChildViewControllers()
    }
    
    ///< 添加子控制器
    fileprivate func addChildViewControllers() {
        guard let path = Bundle.main.path(forResource: "XHControllersInfo.json", ofType: nil),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .init(rawValue: 0)),
            let info = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let infoArray = info as? [[String : Any]] else {
                return
        }
        for vcInfo in infoArray {
            guard let clsName = vcInfo["className"] as? String,
                let bundleName = Bundle.bundleName,
            let vcCls = NSClassFromString(bundleName + "." + clsName),
            let vc = vcCls.alloc() as? UIViewController else {
                continue
            }
            vc.title = vcInfo["title"] as? String
            vc.tabBarItem.image = UIImage(named: vcInfo["normalImage"] as? String ?? "")
            vc.tabBarItem.selectedImage = UIImage(named: vcInfo["selectedImage"] as? String ?? "")
            let nav = XHNavigationController(rootViewController: vc)
            addChildViewController(nav)
        }
    }
}

extension XHTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabBarVc = XHTabBarController()
        tabBarVc.selectedIndex = 2
        UIView.animate(withDuration: 5) {
            
        }
        UIApplication.shared.keyWindow?.rootViewController = tabBarVc
        return true
    }
}
