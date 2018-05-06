//
//  XHRegistViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 21/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHRegistViewController: XHBaseViewController {
    
    lazy var registView: XHRegistView = {
        let rv = XHRegistView()
        rv.xh_delegate = self
        return rv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension XHRegistViewController {
    fileprivate func setupUI() {
        title = "注册学习"
        view.addSubview(registView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        registView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
            make.left.bottom.right.equalTo(view)
        }
    }
}

// MARK: - XHRegistViewDelegate代理
extension XHRegistViewController: XHRegistViewDelegate {
    func registViewDidTapHaveAccountLabel(registView: XHRegistView, sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    ///< 点击了获取验证码的按钮
    func registViewDidClickGetAuthButton(registView: XHRegistView, sender: UIButton) {
        let mobileNumber = registView.mobileNumber
        XHLogin.getAuthCode(withMobile: mobileNumber!, isRegist: true, success: {
            XHAlertHUD.showSuccess(withStatus: "验证码已成功发送", completion: {
                registView.startCountingDown()
            })
        }) {
            (errorReason) in
            registView.getAuthButtonEnable = true
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
    
    ///< 点击了注册按钮
    func registViewDidClickRegistButton(registView: XHRegistView, sender: UIButton) {
        guard let info = registView.info else {
            return
        }
        XHLogin.regist(withAccount: info.account, password: info.password, mobile: info.mobile, authCode: info.authCode, success: {
            XHAlertHUD.showSuccess(withStatus: "注册成功, 请重新登录", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }) { (error) in
            XHAlertHUD.showError(withStatus: error)
        }
    }
}
