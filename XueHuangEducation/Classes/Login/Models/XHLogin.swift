//
//  XHLogin.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetAuthCodeSuccess = () -> ()
typealias XHGetAuthCodeFailue = (String) -> ()
typealias XHMobileLoginSuccess = (XHLoginMember) -> ()
typealias XHMobileLoginFailue = (String) -> ()
typealias XHAccountLoginSuccess = (XHLoginMember) -> ()
typealias XHAccountLoginFailue = (String) -> ()
typealias XHGetPwdSuccess = (XHGetPasswordResult) -> ()
typealias XHGetPwdFailue = (String) -> ()
typealias XHModifyPwdSuccess = () -> ()
typealias XHModifyPwdFailue = (String) -> ()
typealias XHLoginOutSuccess = () -> ()
typealias XHLoginOutFailue = (String) -> ()
typealias XHRegistSuccess = () -> ()
typealias XHRegistFailue = (String) -> ()

class XHLogin {
    
    /// 获取验证码的逻辑
    ///
    /// - Parameters:
    ///   - withMobile: 手机号码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func getAuthCode(withMobile: String, isRegist: Bool, success: XHGetAuthCodeSuccess?, failue: XHGetAuthCodeFailue?) {
        var params: [String: Any]
        if isRegist {
            params = [
                "telphone" : withMobile,
                "isRegister" : "true"
            ]
        }else {
            params = [
                "telphone" : withMobile,
                "isRegister" : "false"
            ]
        }
        XHNetwork.GET(url: URL_APP_REGIST_GET_CODE, params: params, success: { (response) in
            guard let json = response as? [String : Any],
                let result = XHGetAuthCodeResult(JSON: json),
                let code = result.success else {
                    return
            }
            if code == 1 {
                if let msg = result.msg {
                    failue?(msg)
                }else {
                    success?()
                }
            }else {
                if let msg = result.msg {
                    failue?(msg)
                }else {
                    failue?("发送验证码失败")
                }
            }
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("发送验证码失败")
            }
        }
    }
    
    /// 手机登录的逻辑
    ///
    /// - Parameters:
    ///   - withMobile: 手机号码
    ///   - authCode: 验证码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func mobileLogin(withMobile: String, authCode: String, success: XHMobileLoginSuccess?, failue: XHMobileLoginFailue?) {
        let params = [
            "phone" : withMobile,
            "code" : authCode
        ]
        XHNetwork.GET(url: URL_APP_REGIST_PHONE_LOGIN, params: params, success: { (response) in
            guard let json = response as? [String : Any],
            let result = XHMobileLoginResult(JSON: json),
                let code = result.result else {
                    return
            }
            if code == "ok" {
                guard let member = result.member else {
                    failue?("登录失败")
                    return
                }
                success?(member)
            }else if code == "error" {
                failue?("登录失败")
            }else {
                failue?("登录失败")
            }
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("登录失败")
            }
        }
    }
    
    
    /// 账号密码登录的逻辑
    ///
    /// - Parameters:
    ///   - withAccount: 账号
    ///   - password: 密码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func accountLogin(withAccount: String, password: String, success: XHAccountLoginSuccess?, failue: XHAccountLoginFailue?) {
        let params = [
            "UserName" : withAccount,
            "Password" : password,
            "stamp" : "\(arc4random())"
        ]
        XHNetwork.GET(url: URL_APP_LOGIN_PASSWORD_LOGIN, params: params, success: { (response) in
            guard let json = response as? [String : Any],
                let result = XHAccountLoginResult(JSON: json),
                let loginState = result.states,
                let member = result.member else {
                    return
            }
            if loginState == true { ///< 登录成功
                success?(member)
            }else { ///< 登录失败
                guard let result = result.result else {
                    failue?("登录失败")
                    return
                }
                if result.msg == "noaccount" {
                    failue?("此账户还未注册")
                }else {
                    failue?("登录失败")
                }
                
            }
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("登录失败")
            }
        }
    }
    
    /// 找回密码
    ///
    /// - Parameters:
    ///   - withMobile: 手机号码
    ///   - authCode: 手机验证码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func getPassword(withMobile: String, success: XHGetPwdSuccess?, failue: XHGetPwdFailue?) {
        let params = [
            "telphone" : withMobile,
        ]
        XHNetwork.GET(url: URL_APP_LOGIN_GET_PASSWORD, params: params, success: { (response) in
            guard let json = response as? [String : Any],
                let result = XHGetPasswordResult(JSON: json),
                let code = result.result else {
                    return
            }
            if code == "ok" { ///< 有该用户, 并且成功获取验证码
                success?(result)
            }else if code == "no" { ///< 有该用户但获取验证码失败
                failue?(result.msg ?? "获取验证码失败")
            }else if code == "nophone" {
                failue?("此号码没有注册记录")
            }else {
                failue?("获取验证码失败")
            }
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("获取验证码失败")
            }
        }
    }
    
    /// 重新输入密码的接口
    ///
    /// - Parameters:
    ///   - password: 密码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func reinputPassword(password: String, success: XHModifyPwdSuccess?, failue: XHModifyPwdFailue?) {
        guard let result = XHPreferences[.USERDEFAULT_GET_PASSWORD_RESULT_KEY],
        let userID = result.userid else {
            return
        }
        let params = [
            "id" : userID,
            "loginPassword" : password
            ]
        XHNetwork.GET(url: URL_APP_LOGIN_ALTER_PASSWORD, params: params, success: { (response) in
            guard let json = response as? [String : Any],
                let result = XHModifyPwdResult(JSON: json),
                let code = result.result else {
                    return
            }
            if code == "ok" { ///< 有该用户, 并且成功获取验证码
                success?()
            }else {
                failue?("修改密码失败")
            }
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("修改密码失败")
            }
        }
    }
    
    ///< 登出的接口貌似有问题
    
    /// 退出的接口
    ///
    /// - Parameters:
    ///   - success: 退出成功的回调
    ///   - failue: 退出失败的回调
    class func loginOut(success:XHLoginOutSuccess?, failue: XHLoginOutFailue?) {
        XHNetwork.GET(url: URL_LOGIN_OUT, params: nil, success: { (response) in
            success?()
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("退出失败")
            }
        }
    }
    
    class func regist(withAccount account: String, password: String, mobile: String, authCode: String, success: XHRegistSuccess?, failue: XHRegistFailue?) {
        let params = [
            "account" : account,
            "loginPassword" : password,
            "phonebind" : mobile,
            "code" : authCode
        ]
        XHNetwork.GET(url: URL_DO_REGIST, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any] else {
                failue?("注册失败")
                return
            }
            guard let registModel = XHRegistResult(JSON: responseJson),
                let result = registModel.result else {
                    failue?("注册失败")
                    return
            }
            if result == "ok" { ///< 注册成功
                success?()
            }else {
                failue?("注册失败")
            }
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("注册失败")
            }
        }
    }
}
