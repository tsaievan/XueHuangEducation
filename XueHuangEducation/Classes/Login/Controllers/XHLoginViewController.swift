//
//  XHLoginViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHLoginViewController: XHBaseViewController {
    
    ///< 大的登录页面
    lazy var loginView: XHLoginView = {
        let view = XHLoginView()
        view.xh_delegate = self
        return view
    }()
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if presentingViewController == nil {
            loginView.snp.remakeConstraints { (make) in
                make.edges.equalTo(view)
            }
        }else {
            navigationItem.title = "登录"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(dismissLoginViewController))
            loginView.snp.remakeConstraints { (make) in
                make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
                make.left.bottom.right.equalTo(view)
            }
        }
    }
}


// MARK: - 设置UI
extension XHLoginViewController {
    fileprivate func setupUI() {
        view.addSubview(loginView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

// MARK: - LoginView的一些代理
extension XHLoginViewController: XHLoginViewDelegate {
    func loginViewDidLogin(loginView: XHLoginView) {
        guard let info = loginView.info else {
            return
        }
        XHAlertHUD.show(timeInterval: 0)
        ///< 在控制器中写一些重要的逻辑
        if loginView.loginType == .accountLogin {
            
            ///< 账号登录
            XHLogin.accountLogin(withAccount: info.account!, password: info.password!, success: {
                (response) in
                ///< completion的闭包中要写一些登录成功的逻辑
                XHAlertHUD.showSuccess(withStatus: "登录成功", completion: {
                    ///< 将member数据保存到用户偏好设置里面去
                    XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = response
                    if let username = response.accounts {
                        XHPreferences[.USERDEFAULT_LOGIN_ACCOUNT] = username
                    }
                    if let mobile = response.phonebind {
                        XHPreferences[.USERDEFAULT_LOGIN_MOBILE] = mobile
                    }
                    if XHPreferences[.USERDEFAULT_SWICH_ALLOW_CACHE_VIDEO_KEY] {
                        XHDownload.startAllDownloads()
                    }else {
                        if XHNetwork.isReachableOnEthernetOrWiFi() {
                            XHDownload.startAllDownloads()
                        }
                    }
                    if self.presentingViewController == nil {
                        let tabBarController = XHTabBarController()
                        UIApplication.shared.keyWindow?.rootViewController = tabBarController
                    }else {
                        guard let tabVc = UIApplication.shared.keyWindow?.rootViewController as? XHTabBarController,
                            let viewControllers = tabVc.viewControllers,
                            let nav = viewControllers[1] as? XHNavigationController else {
                                return
                        }
                        nav.viewControllers.first?.title = "退出登录"
                        self.dismissLoginViewController()
                    }
                })
            }, failue: { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
        if loginView.loginType == .phoneLogin {
            XHLogin.mobileLogin(withMobile: info.account!, authCode: info.password!, success: { (member) in
                ///< 这里写登录成功的逻辑, 跟账号登录一样
                XHAlertHUD.showSuccess(withStatus: "登录成功", completion: {
                    ///< 将member数据保存到用户偏好设置里面去
                    XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = member
                    if let username = member.accounts {
                        XHPreferences[.USERDEFAULT_LOGIN_ACCOUNT] = username
                    }
                    if let mobile = member.phonebind {
                        XHPreferences[.USERDEFAULT_LOGIN_MOBILE] = mobile
                    }
                    if self.presentingViewController == nil {
                        let tabBarController = XHTabBarController()
                        UIApplication.shared.keyWindow?.rootViewController = tabBarController
                    }else {
                        guard let tabVc = UIApplication.shared.keyWindow?.rootViewController as? XHTabBarController,
                            let viewControllers = tabVc.viewControllers,
                            let nav = viewControllers[1] as? XHNavigationController else {
                                return
                        }
                        nav.viewControllers.first?.title = "退出登录"
                        self.dismissLoginViewController()
                    }
                    
                })
            }) { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            }
        }
    }
    
    func loginViewDidGetAuthCode(loginView: XHLoginView) {
        guard let info = loginView.info else {
            return
        }
        XHAlertHUD.show(timeInterval: 0)
        ///< 调获取验证码的接口
        weak var weakSelf = self
        XHLogin.getAuthCode(withMobile: info.account!, isRegist: false, success: {
            XHAlertHUD.showSuccess(withStatus: "验证码已成功发送", completion: {
                guard let ws = weakSelf else {
                    return
                }
                ws.loginView.setupTimer()
            })
        }) {
            (errorReason) in
            guard let ws = weakSelf else {
                return
            }
            ws.loginView.getAuthButtonEnable = true
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
    
    func loginViewDidRestPassword(loginView: XHLoginView) {
        let resetVc = XHResetPwdViewController()
        resetVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(resetVc, animated: true)
    }
    
    func loginViewDidRegist(loginView: XHLoginView) {
        let registVc = XHRegistViewController()
        registVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(registVc, animated: true)
    }
}

extension XHLoginViewController {
    @objc
    fileprivate func dismissLoginViewController() {
        dismiss(animated: true, completion: nil)
    }
}

