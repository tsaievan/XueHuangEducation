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

///< 2. 获取网校讲题页面数据
let URL_TO_MOBILE_NET_COURSE = "xhweb/appController.do?toMobileNetCourse"

///< 3. 获取网校讲题课件页面数据
let URL_TO_NET_COURSE_WARE = "xhweb/appController.do?toNetCourseware"

///< 4. 退出登录
let URL_LOGIN_OUT = "xhweb/appController.do?loginOut"

///< 5. 获取考卷列表数据
let URL_TO_MOBILE_PAPER_LIST = "xhweb/appController.do?toMobilePaperList"

///< 6. 考卷类型页面数据
let URL_MOBILE_PAPER_CATALOG = "xhweb/appController.do?mobilePaperCatalog"

///< 7. 加载考卷分类
let URL_MOBILE_PAPER_CATALOG_NEW = "xhweb/appController.do?getTree"

///< 8. 获取做题页面数据
let URL_MOBILE_PAPER_QUESTION = "/xhweb/mobileController.do?mobilePaperQuestion"

///< 11. 查询解析内容
let URL_CHECK_ANALYSIS_CONTENT = "/xhweb/mobileController.do?viewJx"

///< 13. 判断用户是否有做题记录
let URL_HAS_QUESTION_LOG = "xhweb/appController.do?isQuestionLog"

///< 13. 获取在线应答页面数据
let URL_TO_QUESTION_LIST = "xhweb/appController.do?toCourseCatalog"

///< 15. 获取本课程问答列表及查询问答
let URL_GET_QUESTION_LIST = "/xhweb/mobileController.do?toQuestionList"

///< 18. 获取个人中心的数据
let URL_TO_MOBILE_PERSON = "xhweb/appController.do?toMobilePerson"

///< 19. 获取个人讲题页面数据
let URL_TO_MY_MOBILE_NET_COURSE = "xhweb/appController.do?toMyMobileNetCourse"

///< 20. 获取个人题库的数据
let URL_TO_MY_MOBIE_PAPER_LIST = "xhweb/appController.do?toMemMobilePaperList"

///< 21. 获取个人在线答疑数据
let URL_TO_MY_QUESTION_LIST = "xhweb/appController.do?toMyCourseCatalog"

///< 21. 手机快捷登录
let URL_APP_REGIST_PHONE_LOGIN = "xhweb/appRegist.do?phoneLogin"

///< 23. 手机注册
let URL_DO_REGIST = "xhweb/appRegist.do?doRegist"

///< 24. 获取手机验证码
let URL_APP_REGIST_GET_CODE = "xhweb/appRegist.do?getCode"

///< 26. 密码验证登录
let URL_APP_LOGIN_PASSWORD_LOGIN = "xhweb/appLogin.do?doLogin"

///< 27. 找回密码
let URL_APP_LOGIN_GET_PASSWORD = "xhweb/appLogin.do?getPassword"

///< 28. 修改密码
let URL_APP_LOGIN_ALTER_PASSWORD = "xhweb/appLogin.do?alterPassword"

///< 29. 解密播放视频链接
let URL_APP_DECRYPT_VIDEO_PLAYER_URL = "xhweb/appController.do?getDecryptPlayMp4Url"

///< 35. 判断用户是否有做题权限
let URL_IS_ALLOWED_ANSWER_QUESTION = "xhweb/paperCatalogController.do?isPriviAnsQuestion"

