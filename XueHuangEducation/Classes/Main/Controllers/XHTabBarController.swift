//
//  XHTabBarController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

enum XHViewControllers: Int {
    case homepage = 0
    case login = 1
    case profile = 2
}

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
            let infoArray = info as? [[[String : Any]]] else {
                return
        }
        if let _ = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] {
            guard let vcArray = infoArray.first else {
                return
            }
            for vcInfo in vcArray {
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
        }else {
            guard let vcArray = infoArray.last else {
                return
            }
            for vcInfo in vcArray {
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
}

extension XHTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let loginVc = viewController.childViewControllers.first,
            let viewControllers = tabBarController.viewControllers,
            let bundleName = Bundle.bundleName,
        let kls = NSClassFromString(bundleName + "." + "XHLoginViewController") else {
            return true
        }
        if loginVc.isKind(of: kls) && viewController == viewControllers[XHViewControllers.login.rawValue] { ///< 表明是登录页面
            if let _ = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] {
                let alert = UIAlertController(title: "确定要退出登录吗?", message: nil, preferredStyle: .alert)
                ///< 退出登录后清空用户数据
                let action = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
//                    XHLogin.loginOut(success: {
//                        XHAlertHUD.showSuccess(withStatus: "退出成功", completion: {
//                            XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = nil
//                            let tabBarController = XHTabBarController()
//                            UIApplication.shared.keyWindow?.rootViewController = tabBarController
//                            ///< 默认选中登录页面
//                            tabBarController.selectedIndex = XHViewControllers.login.rawValue
//                        })
//                    }, failue: { (errorReason) in
//                        XHAlertHUD.showError(withStatus: errorReason)
//                    })
                    XHAlertHUD.showSuccess(withStatus: "退出成功", completion: {
                        ///< 退出登录的时候要把cookie清空
                        HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
                        XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = nil
                        let tabBarController = XHTabBarController()
                        UIApplication.shared.keyWindow?.rootViewController = tabBarController
                        ///< 默认选中登录页面
                        tabBarController.selectedIndex = XHViewControllers.login.rawValue
                    })
                })
                let cancel = UIAlertAction(title: "取消", style: .default, handler: nil)
                alert.addAction(action)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                return false
            }else {
                return true
            }
        }
        if viewController == viewControllers[XHViewControllers.profile.rawValue] {
            let tabBarController = XHTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = tabBarController
            tabBarController.selectedIndex = XHViewControllers.profile.rawValue
        }
        return true
    }
}
