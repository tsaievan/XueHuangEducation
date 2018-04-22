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
        btn.setTitleColor(COLOR_GLOBAL_DARKGRAY, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = COLOR_BUTTON_BORDER_GETAUTH_DARKGRAY.cgColor
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(didClickGetAuthButtonAction), for: .touchUpInside)
        return btn
    }()
    
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
        addSubview(registButton)
        addSubview(getAuthButton)
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
        
        registButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(userAccountTextField)
        }
    }
}


// MARK: - 按钮点击事件
extension XHRegistView {
    @objc fileprivate func didClickRegistButtonAction(sender: UIButton) {
        
    }
    
    @objc fileprivate func didClickGetAuthButtonAction(sender: UIButton) {
        
    }
}
