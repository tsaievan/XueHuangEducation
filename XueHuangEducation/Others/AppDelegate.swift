//
//  AppDelegate.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import ZFDownload

let XHDownload: ZFDownloadManager = {
    let d = ZFDownloadManager.shared()
    ///< 默认并发下载1个视频 (需求如此)
    d!.maxCount = 1
    return d!
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    weak var pushTimer: Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = XHTabBarController()
        window?.makeKeyAndVisible()
        setAlertHudAttributes()
        downloadHomepageData()
        registNotification()
        
        let push = XHPreferences[.USERDEFAULT_SWICH_ALLOW_PUSH_INFO_KEY]
        if push {
            startGetPushedNotificationTimer()
        }else {
            invaliatedGetPushedNotificationTimer()
        }
        return true
    }
    
    ///< app即将失去焦点
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    ///< app已经进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        ///< 这一句很重要
        UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
    }

    ///< app即将进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    ///< app已经成为焦点
    func applicationDidBecomeActive(_ application: UIApplication) {
        ///< 这里要判断一下能否用当前cookie请求到账号, 如果不能, 提示用户退出
        
        ///< 根据需求, 先注释掉这个功能
        
        guard let nav = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers[XHViewControllers.profile.rawValue] as? XHNavigationController,
            let loginVc = nav.childViewControllers.first,
            let bundleName = Bundle.bundleName,
            let kls = NSClassFromString(bundleName + "." + "XHLoginViewController") else {
                return
        }
        if !loginVc.isKind(of: kls) {
            XHProfile.getMobile(success: { (response) in
                guard let _ = response["userName"] else {
                    XHAlertHUD.dismiss()
                    XHGlobalLoading.stopLoading()
                    let alerVc = UIAlertController(title: "信息", message: "您已经长时间未操作, 请重新登录", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                        ///< 退出登录的时候要把cookie清空
                        HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
                        ///< 将cookie的接受改为一直
                        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
                        XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = nil
                        let tabBarController = XHTabBarController()
                        UIApplication.shared.keyWindow?.rootViewController = tabBarController
                        ///< 默认选中登录页面
                        tabBarController.selectedIndex = XHViewControllers.login.rawValue
                    })
                    alerVc.addAction(confirm)
                    UIApplication.shared.keyWindow?.rootViewController?.present(alerVc, animated: true, completion: nil)
                    return
                }
            }, failue: nil)
        }
        ///< 开始监听网络状态的变化
        XHNetwork.startMonitor()
        
        if XHPreferences[.USERDEFAULT_SWICH_ALLOW_CACHE_VIDEO_KEY] { ///< 表明用户此时是打开允许缓存开关的, 此时只要有网就开始下载
            XHDownload.startAllDownloads()
        }else { ///< 关闭2g/3g/4g开关,此时要判断是否有wifi, 有就下载, 没有就不下载
            if XHNetwork.isReachableOnEthernetOrWiFi() {
                XHDownload.startAllDownloads()
            }
        }
    }

    ///< 在app即将退出的时候, 将当前的cookie保存下来
    ///< Note: 这个方法是不主动执行的, 必须要在 `applicationDidEnterBackground` 这个代理方法中
    ///< 写上`UIApplication.shared.beginBackgroundTask(expirationHandler: nil)`这一句才可以
    ///< 进入程序即将退出这个代理方法
    func applicationWillTerminate(_ application: UIApplication) {
        
        ///< 根据需求先注释掉这个功能
        
//        let cookieJar = HTTPCookieStorage.shared
//        guard let cookies = cookieJar.cookies else {
//            return
//        }
//        for cookie in cookies {
//            var properties = cookie.properties
//            properties?.removeValue(forKey: HTTPCookiePropertyKey.discard)
//            let date = Date(timeIntervalSinceNow: 3600 * 24 * 30 * 12)
//            properties?[HTTPCookiePropertyKey.expires] = date
//            guard let pros = properties,
//            let newCookie = HTTPCookie(properties: pros) else {
//                continue
//            }
//            cookieJar.setCookie(newCookie)
//        }
        
        ///< 退出登录的时候要把cookie清空
        HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
        ///< 将cookie的接受改为一直
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = nil
        let tabBarController = XHTabBarController()
        UIApplication.shared.keyWindow?.rootViewController = tabBarController
        
        ///< 暂停视频的下载
        XHDownload.pauseAllDownloads()
        ///< 默认选中登录页面
        tabBarController.selectedIndex = XHViewControllers.login.rawValue
    }
}

extension AppDelegate {
    ///< 设置SVProgressHUD的相关全局属性
    fileprivate func setAlertHudAttributes() {
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.85))
        ///< 显示hud的时候禁止用户交互
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(UIColor.white)
    }
}

extension AppDelegate {
    func startGetPushedNotificationTimer() {
        let timer =  Timer(timeInterval: 10, target: self, selector: #selector(getNotificationAction), userInfo: nil, repeats: true)
        pushTimer = timer
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func invaliatedGetPushedNotificationTimer() {
        pushTimer?.invalidate()
    }
}

extension AppDelegate {
    @objc
    fileprivate func getNotificationAction() {
        XHPush.getPushedNotification(success: { (response) in
            
            ///< iOS 10.0 以上的消息推送
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                guard let title = response.title,
                let pushId = response.pushId,
                let details = response.details else {
                    return
                }
                content.title = title
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let requestIdentifier = pushId
                let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                    DispatchQueue.main.async {
                        let view = XHAdvertisement
                        view.frame = CGRect(x: 0, y: -XHSCreen.height, width: XHSCreen.width, height: XHSCreen.height)
                        view.content = details
                        self.window?.addSubview(view)
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                            view.frame = CGRect(x: 0, y: 0, width: XHSCreen.width, height: XHSCreen.height)
                        }, completion: nil)
                    }
                })
            } else { ///< iOS 10.0 以下的消息推送
                
            }
            
        }, failue: nil)
    }
}

// MARK: - 通知相关
extension AppDelegate {
    fileprivate func registNotification() {
        ///< iOS10 以后的版本
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (accepted, error) in
                if !accepted {
                    XHPreferences[.USERDEFAULT_SWICH_ALLOW_PUSH_INFO_KEY] = false
                }else {
                    XHPreferences[.USERDEFAULT_SWICH_ALLOW_PUSH_INFO_KEY] = true
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
}

