//
//  AppDelegate.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = XHTabBarController()
        window?.makeKeyAndVisible()
        setAlertHudAttributes()
        downloadHomepageData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        ///< 这一句很重要
        UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
    }

    ///< app即将进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        ///< 这里要判断一下能否用当前cookie请求到账号, 如果不能, 提示用户退出
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    ///< 在app即将退出的时候, 将当前的cookie保存下来
    ///< Note: 这个方法是不主动执行的, 必须要在 `applicationDidEnterBackground` 这个代理方法中
    ///< 写上`UIApplication.shared.beginBackgroundTask(expirationHandler: nil)`这一句才可以
    ///< 进入程序即将退出这个代理方法
    func applicationWillTerminate(_ application: UIApplication) {
        let cookieJar = HTTPCookieStorage.shared
        guard let cookies = cookieJar.cookies else {
            return
        }
        for cookie in cookies {
            var properties = cookie.properties
            properties?.removeValue(forKey: HTTPCookiePropertyKey.discard)
            let date = Date(timeIntervalSinceNow: 3600 * 24 * 30 * 12)
            properties?[HTTPCookiePropertyKey.expires] = date
            guard let pros = properties,
            let newCookie = HTTPCookie(properties: pros) else {
                continue
            }
            cookieJar.setCookie(newCookie)
        }
    }
}

extension AppDelegate {
    ///< 设置SVProgressHUD的相关全局属性
    fileprivate func setAlertHudAttributes() {
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.85))
        SVProgressHUD.setForegroundColor(UIColor.white)
    }
}

