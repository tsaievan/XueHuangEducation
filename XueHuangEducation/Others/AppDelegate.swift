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
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    ///< 在app即将退出的时候, 将当前的cookie保存下来
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

