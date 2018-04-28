//
//  XHNetworkConstant.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
///< baseURL
let URL_BASE = "http://120.77.242.84:8083"

///< 1. 获取主页面数据
let URL_HOMEPAGE_LIST = "xhweb/appController.do?list"

///< 21. 手机快捷登录
let URL_APP_REGIST_PHONE_LOGIN = "xhweb/appRegist.do?phoneLogin"

///< 23. 获取手机验证码
let URL_APP_REGIST_GET_CODE = "xhweb/appRegist.do?getCode"

///< 26. 密码验证登录
let URL_APP_LOGIN_PASSWORD_LOGIN = "xhweb/appLogin.do?doLogin"

///< 27. 找回密码
let URL_APP_LOGIN_GET_PASSWORD = "xhweb/appLogin.do?getPassword"

///< 28. 修改密码
let URL_APP_LOGIN_ALTER_PASSWORD = "xhweb/appLogin.do?alterPassword"

///< 29. 解密播放视频链接
let URL_APP_DECRYPT_VIDEO_PLAYER_URL = "xhweb/appController.do?getDecryptPlayMp4Url"

