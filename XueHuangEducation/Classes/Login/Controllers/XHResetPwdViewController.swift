//
//  XHResetPwdViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHResetPwdViewController: XHBaseViewController {
    ///< 重置密码的页面
    lazy var resetPwdView: XHLoginDetailView = {
        let view = XHLoginDetailView(loginType: .resetPassword)
        view.backgroundColor = .white
        view.xh_delegate = self
        return view
    }()
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - 设置UI
extension XHResetPwdViewController {
    fileprivate func setupUI() {
        view.addSubview(resetPwdView)
        title = "找回密码"
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        resetPwdView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
            make.left.bottom.right.equalTo(view)
        }
    }
}

// MARK: - XHLoginDetailViewDelegate代理
extension XHResetPwdViewController: XHLoginDetailViewDelegate {
    func loginDetailViewDidClickGetAuthButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        guard let info = loginDetailView.info else {
            return
        }
        ///< 调找回密码的接口
        XHAlertHUD.show(timeInterval: 0)
        XHLogin.getPassword(withMobile: info.account!, success: { (response) in
            guard let _ = response.username,
                let _ = response.userid else {
                    XHAlertHUD.showError(withStatus: "暂时不能找回密码")
                    return
            }
            XHAlertHUD.showSuccess(withStatus: "验证码已成功发送")
            response.currentTime = CFAbsoluteTimeGetCurrent()
            ///< 这里要将response持久化存储起来
            XHPreferences[.USERDEFAULT_GET_PASSWORD_RESULT_KEY] = response
        }) { ///< 调取接口失败
            (string) in
            XHAlertHUD.showError(withStatus: string)
            self.resetPwdView.getAuthButtonEnable = true
        }
    }
    
    ///< 点击下一步按钮
    func loginDetailViewDidClickLoginButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        guard let info = loginDetailView.info,
            let inputAuthCode = info.password,
            let response = XHPreferences[.USERDEFAULT_GET_PASSWORD_RESULT_KEY],
            let saveAuthCode = response.code,
            let currentTime = response.currentTime else {
                XHAlertHUD.showError(withStatus: "验证码错误")
                return
        }
        if (CFAbsoluteTimeGetCurrent() - currentTime >= TIME_INTERVAL_MAX_GET_AUTH_CODE) { ///< 超过了最大时间, 需要重新获取验证码
            XHAlertHUD.showError(withStatus: "验证码超时, 请重新获取")
            return
        }
        ///< 输入的字符串和保留的字符串相同, 表明验证成功, 进行下一步操作
        if inputAuthCode == saveAuthCode { ///< 跳转到下一级控制器
            let nextVc = XHResetPwdNextViewController()
            nextVc.response = response
            navigationController?.pushViewController(nextVc, animated: true)
        }else {
            XHAlertHUD.showError(withStatus: "验证码错误")
        }
    }
}
