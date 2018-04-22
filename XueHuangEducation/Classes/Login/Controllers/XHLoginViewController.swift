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
        view.delegate = self
        return view
    }()
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

extension XHLoginViewController: XHLoginViewDelegate {
    func loginViewDidLogin(loginView: XHLoginView) {
        guard let info = loginView.info else {
            return
        }
        XHAlertHUD.show(timeInterval: 0)
        ///< 在控制器中写一些重要的逻辑
        if loginView.loginType == .accountLogin {
            XHLogin.accountLogin(withAccount: info.account!, password: info.password!, success: {
                
            }, failue: { (errorReason) in
                
            })
            
        }
        if loginView.loginType == .phoneLogin {
            XHLogin.mobileLogin(withMobile: info.account!, authCode: info.password!, success: {
                XHAlertHUD.showSuccess(withStatus: "登录成功", completion: {
                    print("登录成功")
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
        XHLogin.getAuthCode(withMobile: info.account!, success: {
            self.loginView.setupTimer()
        }) {
            self.loginView.getAuthButtonEnable = true
            XHAlertHUD.showError(withStatus: "发送失败")
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

