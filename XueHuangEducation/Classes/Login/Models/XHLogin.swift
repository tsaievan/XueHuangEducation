//
//  XHLogin.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetAuthCodeSuccess = () -> ()
typealias XHGetAuthCodeFailue = () -> ()
typealias XHLoginSuccess = () -> ()
typealias XHLoginFailue = (String) -> ()
typealias XHGetPwdSuccess = (XHGetPasswordResult) -> ()
typealias XHGetPwdFailue = (String) -> ()

class XHLogin {
    
    /// 获取验证码的逻辑
    ///
    /// - Parameters:
    ///   - withMobile: 手机号码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func getAuthCode(withMobile: String, success: XHGetAuthCodeSuccess?, failue: XHGetAuthCodeFailue?) {
        let params = [
            "telphone" : withMobile,
            "isRegister" : "false"
        ]
        XHNetwork.GET(url: URL_APP_REGIST_GET_CODE, params: params, success: { (response) in
            guard let json = response as? [String : Any],
                let result = XHGetAuthCodeResult(JSON: json),
                let code = result.success else {
                    return
            }
            if code == 1 {
                success?()
            }else {
                failue?()
            }
        }) { (error) in
            failue?()
        }
    }
    
    /// 手机登录的逻辑
    ///
    /// - Parameters:
    ///   - withMobile: 手机号码
    ///   - authCode: 验证码
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func mobileLogin(withMobile: String, authCode: String, success: XHLoginSuccess?, failue: XHLoginFailue?) {
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
                success?()
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
    class func accountLogin(withAccount: String, password: String, success: XHLoginSuccess?, failue: XHLoginFailue?) {
        let params = [
            "UserName" : withAccount,
            "Password" : password,
            "stamp" : "\(arc4random())"
        ]
        XHNetwork.GET(url: URL_APP_LOGIN_PASSWORD_LOGIN, params: params, success: { (response) in
            guard let json = response as? [String : Any],
                let result = XHAccountLoginResult(JSON: json),
                let loginState = result.states else {
                    return
            }
            if loginState == true { ///< 登录成功
                                success?()
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
//            if code == "ok" {
//                success?()
//            }else if code == "error" {
//                failue?("登录失败")
//            }else {
//                failue?("登录失败")
//            }
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
    
    class func reinputPassword(password: String, success: XHGetPwdSuccess?, failue: XHGetPwdFailue?) {
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
}
