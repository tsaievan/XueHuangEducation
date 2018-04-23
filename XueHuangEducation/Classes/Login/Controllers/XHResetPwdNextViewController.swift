//
//  XHResetPwdNextViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 21/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHResetPwdNextViewController: XHBaseViewController {
    
    ///< 输入密码两次的页面
    lazy var resetPwdView: XHLoginDetailView = {
        let view = XHLoginDetailView(loginType: .reinput)
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = COLOR_CLOBAL_LIGHT_GRAY
        lbl.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        lbl.textAlignment = .center
        guard let username = response?.username else {
            return lbl
        }
        lbl.text = "您好! \(username)"
        return lbl
    }()
    
    var response: XHGetPasswordResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - 设置UI
extension XHResetPwdNextViewController {
    fileprivate func setupUI() {
        title = "重置密码"
        view.addSubview(nameLabel)
        view.addSubview(resetPwdView)
        view.backgroundColor = .white
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(UIDevice.iPhoneX ? 84 + 15 : 64 + 15)
            make.left.right.equalTo(view)
        }
        
        resetPwdView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
    }
}

// MARK: - XHLoginDetailViewDelegate代理
extension XHResetPwdNextViewController: XHLoginDetailViewDelegate {
    ///< 点击了确认按钮
    func loginDetailViewDidClickLoginButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        guard let info = loginDetailView.info else {
            return
        }
        weak var weakSelf = self
        XHLogin.reinputPassword(password: info.account!, success: { () in
            ///< 登录成功后返回登录页面
            XHAlertHUD.showSuccess(withStatus: "修改成功\n请重新登录", completion: {
                guard let ws = weakSelf else {
                    return
                }
                ws.navigationController?.popToRootViewController(animated: true)
            })
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
}
