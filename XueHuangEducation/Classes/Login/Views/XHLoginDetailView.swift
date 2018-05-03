//
//  XHLoginDetailView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 16/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHLoginDetailViewInfo = (account: String?, password: String?)

///< 登录类型
enum XHLoginViewType {
    case accountLogin ///< 账号登录
    case phoneLogin ///< 手机登录
    case resetPassword ///< 重置密码
    case reinput ///< 输入两次密码
}

@objc
protocol XHLoginDetailViewDelegate: NSObjectProtocol {
    ///< 点击了获取验证码按钮
    @objc optional
    func loginDetailViewDidClickGetAuthButton(loginDetailView: XHLoginDetailView, sender: UIButton)
    
    ///< 点击了登录按钮
    @objc optional
    func loginDetailViewDidClickLoginButton(loginDetailView: XHLoginDetailView, sender: UIButton)
    
    ///< 点击了注册按钮
    @objc optional
    func loginDetailViewDidClickRegistButton(loginDetailView: XHLoginDetailView, sender: UIButton)
    
    ///< 点击了找回密码按钮
    @objc optional
    func loginDetailViewDidClickResetPwdButton(loginDetailView: XHLoginDetailView, sender: UIButton)
}

class XHLoginDetailView: UIView {
    
    ///< 用户名/手机号 输入框
    lazy fileprivate var userAccountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    ///< 密码/验证码输入框
    lazy fileprivate var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    ///< 登录按钮
    lazy fileprivate var loginButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: FONT_SIZE_16)
        btn.setTitle("登 录", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = COLOR_GLOBAL_BLUE
        btn.addTarget(self, action: #selector(didClickLoginButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///< 注册按钮
    lazy fileprivate var registButton: UIButton = {
        let btn = UIButton(title: "注册学习", target: self, action: #selector(didClickRegistButtonAction))
        return btn
    }()
    
    ///< 找回密码按钮
    lazy fileprivate var findPwdButton: UIButton = {
        let btn = UIButton(title: "找回密码", target: self, action: #selector(didClickFindPwdButtonAction))
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
        btn.isHidden = true
        btn.addTarget(self, action: #selector(didClickGetAuthButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///< 发送验证码之后的倒计时器
    weak var countDownTimer: Timer?
    
    ///< 代理
    weak var xh_delegate: XHLoginDetailViewDelegate?
    
    ///< 再次发送验证码剩余时间
    var remainTime: Int = 60
    
    ///< 登录界面的类型
    var viewType: XHLoginViewType = .accountLogin
    
    var accountIsNull: Bool {
        ///< 验证手机号码是否为空
        if userAccountTextField.text == nil {
            if viewType == .accountLogin {
                XHAlertHUD.showError(withStatus: "用户名不能为空")
            }else {
                XHAlertHUD.showError(withStatus: "手机号码不能为空")
            }
            return true
        }
        if userAccountTextField.text! == "" {
            if viewType == .accountLogin {
                XHAlertHUD.showError(withStatus: "用户名不能为空")
            }else {
                XHAlertHUD.showError(withStatus: "手机号码不能为空")
            }
            return true
        }
        return false
    }
    
    ///< 密码/验证码是否为空
    var passwordIsNull: Bool {
        ///< 验证手机号码是否为空
        if passwordTextField.text == nil {
            if viewType == .accountLogin {
                XHAlertHUD.showError(withStatus: "密码不能为空")
            }else {
                XHAlertHUD.showError(withStatus: "验证码不能为空")
            }
            return true
        }
        if passwordTextField.text! == "" {
            if viewType == .accountLogin {
                XHAlertHUD.showError(withStatus: "密码不能为空")
            }else {
                XHAlertHUD.showError(withStatus: "验证码不能为空")
            }
            return true
        }
        return false
    }
    
    var info: XHLoginDetailViewInfo?
    
    ///< 获取验证码的按钮是否禁用
    var getAuthButtonEnable: Bool? {
        didSet {
            guard let enable = getAuthButtonEnable else {
                return
            }
            getAuthButton.isEnabled = enable
        }
    }
    
    ///< 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        registNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(loginType: XHLoginViewType) {
        self.init()
        switch loginType {
        case .accountLogin:
            viewType = .accountLogin
            getAuthButton.isHidden = true
            
            if let username = XHPreferences[.USERDEFAULT_LOGIN_ACCOUNT] {
                userAccountTextField.text = username
            }else if let userInfo = XHPreferences[.USERDEFAULT_GET_PASSWORD_RESULT_KEY],
                let username = userInfo.username {
                userAccountTextField.text = username
            }
            userAccountTextField.placeholder = "请输入用户名"
            passwordTextField.placeholder = "请输入密码"
            passwordTextField.snp.remakeConstraints { (make) in
                make.top.equalTo(userAccountTextField.snp.bottom).offset(15)
                make.leading.height.trailing.equalTo(userAccountTextField)
            }
        case .phoneLogin:
            viewType = .phoneLogin
            getAuthButton.isHidden = false
            if let mobile = XHPreferences[.USERDEFAULT_LOGIN_MOBILE] {
                userAccountTextField.text = mobile
            }else if let userInfo = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY],
                let mobile = userInfo.phonebind {
                userAccountTextField.text = mobile
            }
            userAccountTextField.placeholder = "请输入手机号"
            userAccountTextField.keyboardType = .phonePad
            passwordTextField.placeholder = "请输入验证码"
            passwordTextField.keyboardType = .phonePad
            passwordTextField.isSecureTextEntry = false
            passwordTextField.snp.remakeConstraints { (make) in
                make.top.equalTo(userAccountTextField.snp.bottom).offset(15)
                make.leading.height.equalTo(userAccountTextField)
                make.right.equalTo(getAuthButton.snp.left).offset(-15)
            }
        case .resetPassword:
            viewType = .phoneLogin
            getAuthButton.isHidden = false
            userAccountTextField.placeholder = "请输入手机号"
            userAccountTextField.keyboardType = .phonePad
            passwordTextField.placeholder = "请输入验证码"
            passwordTextField.keyboardType = .phonePad
            passwordTextField.isSecureTextEntry = false
            passwordTextField.snp.remakeConstraints { (make) in
                make.top.equalTo(userAccountTextField.snp.bottom).offset(15)
                make.leading.height.equalTo(userAccountTextField)
                make.right.equalTo(getAuthButton.snp.left).offset(-15)
            }
            loginButton.setTitle("下一步", for: .normal)
            registButton.isHidden = true
            findPwdButton.isHidden = true
        case .reinput:
            viewType = .reinput
            getAuthButton.isHidden = true
            userAccountTextField.placeholder = "请输入密码"
            userAccountTextField.isSecureTextEntry = true
            passwordTextField.placeholder = "请再次输入密码"
            passwordTextField.isSecureTextEntry = true
            passwordTextField.snp.remakeConstraints { (make) in
                make.top.equalTo(userAccountTextField.snp.bottom).offset(15)
                make.leading.height.trailing.equalTo(userAccountTextField)
            }
            registButton.isHidden = true
            findPwdButton.isHidden = true
            loginButton.setTitle("确 定", for: .normal)
        }
    }
    
    ///< 析构函数
    deinit {
        ///< 通知移除观察者
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 设置UI
extension XHLoginDetailView {
    fileprivate func setupUI() {
        addSubview(userAccountTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registButton)
        addSubview(findPwdButton)
        addSubview(getAuthButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        userAccountTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userAccountTextField.snp.bottom).offset(15)
            make.leading.height.trailing.equalTo(userAccountTextField)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.trailing.height.equalTo(userAccountTextField)
        }
        
        registButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(15)
            make.leading.equalTo(loginButton)
        }
        
        findPwdButton.snp.makeConstraints { (make) in
            make.top.equalTo(registButton)
            make.trailing.equalTo(loginButton)
        }
        
        getAuthButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(passwordTextField)
            make.trailing.equalTo(userAccountTextField)
            make.width.equalTo(userAccountTextField).multipliedBy(0.35)
        }
    }
}


// MARK: - 注册通知
extension XHLoginDetailView {
    fileprivate func registNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldContentDidChange), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }
}

// MARK: - 按钮的点击事件
extension XHLoginDetailView {
    ///< 点击了注册按钮
    @objc fileprivate func didClickRegistButtonAction(sender: UIButton) {
        xh_delegate?.loginDetailViewDidClickRegistButton?(loginDetailView: self, sender: sender)
    }
    
    ///< 点击了找回账号按钮
    @objc fileprivate func didClickFindPwdButtonAction(sender: UIButton) {
        xh_delegate?.loginDetailViewDidClickResetPwdButton?(loginDetailView: self, sender: sender)
    }
    
    ///< 点击了发送验证码按钮
    @objc fileprivate func didClickGetAuthButtonAction(sender: UIButton) {
        ///< 验证手机号码是否为空
        if accountIsNull {
            return
        }
        if !XHRegExTool.isPhoneNumber(phoneNumber: userAccountTextField.text!) {
            XHAlertHUD.showError(withStatus: "手机号码格式不正确")
            return
        }
        ///< 不给连续点击的机会
        sender.isEnabled = false
        info = (userAccountTextField.text!, nil)
        xh_delegate?.loginDetailViewDidClickGetAuthButton?(loginDetailView: self, sender: sender)
    }
    
    ///< 点击了登录按钮
    @objc fileprivate func didClickLoginButtonAction(sender: UIButton) {
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
        if userAccountTextField.isFirstResponder {
            userAccountTextField.resignFirstResponder()
        }
        if accountIsNull {
            return
        }
        if passwordIsNull {
            return
        }
        if viewType == .phoneLogin { ///< 如果是验证码的输入框, 还要判断手机号格式是否正确
            if !XHRegExTool.isPhoneNumber(phoneNumber: userAccountTextField.text!) {
                XHAlertHUD.showError(withStatus: "手机号码格式不正确")
                return
            }
        }
        if viewType == .reinput {
            if userAccountTextField.text! != passwordTextField.text! { ///< 两次输入的密码不一致
                XHAlertHUD.showError(withStatus: "两次输入的密码不一致")
                return
            }
        }
        info = (userAccountTextField.text!, passwordTextField.text!)
        xh_delegate?.loginDetailViewDidClickLoginButton?(loginDetailView: self, sender: sender)
    }
}

// MARK: - 通知回调事件
extension XHLoginDetailView {
    ///< 设置最大输入手机位数为11
    @objc fileprivate func textFieldContentDidChange(notification: Notification) {
        guard let textField = notification.object as? UITextField else {
            return
        }
        if textField == userAccountTextField {
            guard let string = userAccountTextField.text else {
                return
            }
            let textString =  string as NSString
            if userAccountTextField.placeholder! == "请输入手机号" { ///< 表明是手机号的输入框
                if textString.length >= 11 {
                    userAccountTextField.text = textString.substring(to: 11)
                }
            }
        }
        
        if textField == passwordTextField {
            ///< 表明是验证码的输入框
            if passwordTextField.placeholder! == "请输入验证码" {
                guard let string = passwordTextField.text else {
                    return
                }
                let textString =  string as NSString
                if textString.length >= 6 {
                    passwordTextField.text = textString.substring(to: 6)
                }
            }
        }
    }
}

// MARK: - 计时器调用事件
extension XHLoginDetailView {
    func startCountingDown() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountingDownAction), userInfo: nil, repeats: true)
        self.countDownTimer = timer
        RunLoop.current.add(self.countDownTimer!, forMode: .commonModes)
    }
    
    @objc fileprivate func timerCountingDownAction() {
        if remainTime <= 1 {
            countDownTimer?.invalidate()
            countDownTimer = nil
            remainTime = 60
            getAuthButton.isEnabled = true
            return
        }
        remainTime -= 1
        let title = "重新发送(\(remainTime))"
        getAuthButton.isEnabled = false
        getAuthButton.setTitle(title, for: .disabled)
        getAuthButton.setTitleColor(COLOR_CLOBAL_LIGHT_GRAY, for: .disabled)
    }
}

// MARK: - 其他事件
extension XHLoginDetailView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userAccountTextField.isFirstResponder {
            userAccountTextField.resignFirstResponder()
        }
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
}
