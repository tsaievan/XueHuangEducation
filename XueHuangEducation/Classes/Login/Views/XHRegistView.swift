//
//  XHRegistView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

@objc
protocol XHRegistViewDelegate: NSObjectProtocol {
    @objc optional
    func registViewDidTapHaveAccountLabel(registView: XHRegistView, sender: UITapGestureRecognizer)
    
    @objc optional
    func registViewDidClickGetAuthButton(registView: XHRegistView, sender: UIButton)
    
    @objc optional
    func registViewDidClickRegistButton(registView: XHRegistView, sender: UIButton)
}

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
    
    ///< `我已有账号!`Label
    lazy var haveAccountLabel: UILabel = {
        let lblText = NSMutableAttributedString(string: "我已有账号!去登录", attributes: [NSAttributedStringKey.foregroundColor : COLOR_GLOBAL_BLUE])
        lblText.setAttributes([NSAttributedStringKey.foregroundColor : COLOR_GLOBAL_DARK_GRAY], range: NSRange(location: 0, length: "我已有账号!".count))
        let lbl = UILabel()
        lbl.attributedText = lblText
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
        lbl.sizeToFit()
        lbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTaphaveAccountLabelAction))
        lbl.addGestureRecognizer(tap)
        return lbl
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
    
    var mobileNumber: String?
    
    ///< 发送验证码之后的倒计时器
    weak var countDownTimer: Timer?
    
    ///< 再次发送验证码剩余时间
    var remainTime: Int = 60
    
    var accountIsNull: Bool {
        ///< 验证用户名是否为空
        if userAccountTextField.text == nil {
            XHAlertHUD.showError(withStatus: "用户名不能为空")
            return true
        }
        if userAccountTextField.text! == "" {
            XHAlertHUD.showError(withStatus: "用户名不能为空")
            return true
        }
        return false
    }
    
    ///< 密码是否为空
    var passwordIsNull: Bool {
        ///< 验证密码是否为空
        if passwordTextField.text == nil {
            XHAlertHUD.showError(withStatus: "密码不能为空")
            return true
        }
        if passwordTextField.text! == "" {
            XHAlertHUD.showError(withStatus: "密码不能为空")
            return true
        }
        return false
    }
    
    var authCodeIsNull: Bool {
        if authCodeTextField.text == nil {
            XHAlertHUD.showError(withStatus: "验证码不能为空")
            return true
        }
        if authCodeTextField.text == "" {
            XHAlertHUD.showError(withStatus: "验证码不能为空")
            return true
        }
        return false
    }
    
    var info: (account: String, password: String, mobile: String, authCode: String)?
    
    ///< 获取验证码的按钮是否禁用
    var getAuthButtonEnable: Bool? {
        didSet {
            guard let enable = getAuthButtonEnable else {
                return
            }
            getAuthButton.isEnabled = enable
        }
    }
    
    weak var xh_delegate: XHRegistViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 生命周期
extension XHRegistView {
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        ///< 每次进入页面, 同意按钮自动打勾
        agreeButton.isSelected = true
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
        addSubview(haveAccountLabel)
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
        
        haveAccountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(registButton.snp.bottom).offset(30)
        }
    }
}


// MARK: - 按钮点击事件
extension XHRegistView {
    
    ///< 点击注册按钮
    @objc fileprivate func didClickRegistButtonAction(sender: UIButton) {
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
        if userAccountTextField.isFirstResponder {
            userAccountTextField.resignFirstResponder()
        }
        if mobieTextField.isFirstResponder {
            mobieTextField.resignFirstResponder()
        }
        if authCodeTextField.isFirstResponder {
            authCodeTextField.resignFirstResponder()
        }
        if accountIsNull {
            return
        }
        if passwordIsNull {
            return
        }
        
        if mobileIsNull {
            return
        }
        if authCodeIsNull {
            return
        }
        if xhProtocolButton.isSelected != true {
            XHAlertHUD.showError(withStatus: "请阅读并同意《学煌教育服务协议》")
            xhProtocolButton.isSelected = true
            return            
        }
        if !XHRegExTool.isPhoneNumber(phoneNumber: mobieTextField.text!) {
            XHAlertHUD.showError(withStatus: "手机号码格式不正确")
            return
        }
        if authCodeTextField.text?.count != 6 {
            XHAlertHUD.showError(withStatus: "验证码不正确")
        }
        info = (account: userAccountTextField.text!, password: passwordTextField.text!, mobile: mobieTextField.text!, authCode: authCodeTextField.text!)
        xh_delegate?.registViewDidClickRegistButton?(registView: self, sender: sender)
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
        mobileNumber = mobieTextField.text!
        xh_delegate?.registViewDidClickGetAuthButton?(registView: self, sender: sender)
    }
    
    ///< 勾选了同意服务协议按钮
    @objc fileprivate func didSelectedAgreeButtonAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    ///< 点击服务协议按钮
    @objc fileprivate func didClickXHProtocolButtonAction(sender: UIButton) {
        
    }
    
    ///< 点击`去登录`label
    @objc fileprivate func didTaphaveAccountLabelAction(sender: UITapGestureRecognizer) {
        xh_delegate?.registViewDidTapHaveAccountLabel?(registView: self, sender: sender)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mobieTextField.isFirstResponder {
            mobieTextField.resignFirstResponder()
        }
        if authCodeTextField.isFirstResponder {
            authCodeTextField.resignFirstResponder()
        }
        if userAccountTextField.isFirstResponder {
            userAccountTextField.resignFirstResponder()
        }
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
}

extension XHRegistView {
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
