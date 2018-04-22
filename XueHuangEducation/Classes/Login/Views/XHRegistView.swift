//
//  XHRegistView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHRegistView: UIView {
    ///< 手机号输入框
    lazy fileprivate var mobieTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入手机号"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    ///< 验证码输入框
    lazy fileprivate var authCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入验证码"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.isSecureTextEntry = false
        textField.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    ///< 用户名输入框
    lazy fileprivate var userAccountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入用户名"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    ///< 密码输入框
    lazy fileprivate var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入密码"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    ///< 同意打勾的按钮
    lazy fileprivate var agreeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "regist_agree_button_normal"), for: .normal)
        btn.setImage(UIImage(named: "regist_agree_button_selected"), for: .selected)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(didSelectedAgreeButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///< 我已经阅读并同意Label
    lazy var agreeDescLabel: UILabel = {
        let lbl = UILabel(text: "我已经阅读并同意", textColor: COLOR_GLOBAL_DARK_GRAY)
        return lbl
    }()
    
    lazy var xhProtocolButton: UIButton = {
        let btn = UIButton(title: "《学煌教育服务协议》", titleColor: COLOR_GLOBAL_BLUE, fontSize: FONT_SIZE_14, target: self, action: #selector(didClickXHProtocolButtonAction), controlEvents: .touchUpInside)
        return btn
    }()
    
    ///< 注册按钮
    lazy fileprivate var registButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: FONT_SIZE_16)
        btn.setTitle("注 册", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = COLOR_GLOBAL_BLUE
        btn.addTarget(self, action: #selector(didClickRegistButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///< 获取验证码按钮
    lazy fileprivate var getAuthButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(COLOR_GLOBAL_DARK_GRAY, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = COLOR_BUTTON_BORDER_GETAUTH_DARKGRAY.cgColor
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(didClickGetAuthButtonAction), for: .touchUpInside)
        return btn
    }()
    
    var mobileIsNull: Bool {
        ///< 验证手机号码是否为空
        if mobieTextField.text == nil {
            XHAlertHUD.showError(withStatus: "手机号码不能为空")
            return true
        }
        if mobieTextField.text! == "" {
            XHAlertHUD.showError(withStatus: "手机号码不能为空")
            return true
        }
        return false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHRegistView {
    fileprivate func setupUI() {
        addSubview(mobieTextField)
        addSubview(authCodeTextField)
        addSubview(userAccountTextField)
        addSubview(passwordTextField)
        addSubview(getAuthButton)
        addSubview(agreeButton)
        addSubview(agreeDescLabel)
        addSubview(xhProtocolButton)
        addSubview(registButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        ///< 手机输入框的布局
        mobieTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.height.equalTo(40)
        }
        
        authCodeTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(mobieTextField.snp.bottom).offset(15)
            make.leading.height.equalTo(mobieTextField)
            make.right.equalTo(getAuthButton.snp.left).offset(-15)
        }
        
        getAuthButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(authCodeTextField)
            make.trailing.equalTo(mobieTextField)
            make.width.equalTo(mobieTextField).multipliedBy(0.35)
        }
        
        userAccountTextField.snp.makeConstraints { (make) in
            make.top.equalTo(authCodeTextField.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(mobieTextField)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userAccountTextField.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(userAccountTextField)
        }
        
        agreeButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalTo(passwordTextField)
        }
        
        agreeDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(agreeButton.snp.right).offset(5)
            make.centerY.equalTo(agreeButton)
        }
        
        xhProtocolButton.snp.makeConstraints { (make) in
            make.left.equalTo(agreeDescLabel.snp.right)
            make.centerY.equalTo(agreeDescLabel)
        }
        
        registButton.snp.makeConstraints { (make) in
            make.top.equalTo(xhProtocolButton.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(userAccountTextField)
        }
    }
}


// MARK: - 按钮点击事件
extension XHRegistView {
    
    ///< 点击注册按钮
    @objc fileprivate func didClickRegistButtonAction(sender: UIButton) {
        
    }
    
    ///< 点击获取验证码按钮
    @objc fileprivate func didClickGetAuthButtonAction(sender: UIButton) {
        ///< 验证手机号码是否为空
        if mobileIsNull {
            return
        }
        if !XHRegExTool.isPhoneNumber(phoneNumber: mobieTextField.text!) {
            XHAlertHUD.showError(withStatus: "手机号码格式不正确")
            return
        }
        ///< 不给连续点击的机会
        sender.isEnabled = false
//        delegate?.loginDetailViewDidClickGetAuthButton?(loginDetailView: self, sender: sender)
    }
    
    ///< 勾选了同意服务协议按钮
    @objc fileprivate func didSelectedAgreeButtonAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    ///< 点击服务协议按钮
    @objc fileprivate func didClickXHProtocolButtonAction(sender: UIButton) {
        
    }
}
