//
//  XHNetworkConstant.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

struct XHURL {
    ///< baseURL
    static let base = "http://120.77.242.84:8083"
    struct MobileController {
        ///< 8. 获取做题页面数据
        static let getPaperQuestion = "/xhweb/mobileController.do?mobilePaperQuestion"
        ///< 11. 查询解析内容
        static let checkAnalysisContent = "/xhweb/mobileController.do?viewJx"
    }
    
    struct AppController {
        ///< 1. 获取主页面数据
        static let list = "xhweb/appController.do?list"
        
        ///< 2. 获取网校讲题页面数据
        static let toMobileNetCourse = "xhweb/appController.do?toMobileNetCourse"
        
        ///< 3. 获取网校讲题课件页面数据
        static let toNetCourseware = "xhweb/appController.do?toNetCourseware"
        
        ///< 4. 退出登录
        static let loginOut = "xhweb/appController.do?loginOut"
        
        ///< 5. 获取考卷列表数据
        static let toMobilePaperList = "xhweb/appController.do?toMobilePaperList"
        
        ///< 7. 加载考卷分类
        static let getTree = "xhweb/appController.do?getTree"
        
        ///< 13. 判断用户是否有做题记录
        static let isQuestionLog = "xhweb/appController.do?isQuestionLog"
        
        ///< 14. 获取在线应答页面数据
        static let toCourseCatalog = "xhweb/appController.do?toCourseCatalog"
        
        
    }
    
    struct NetCourseController {
        ///< 41. 判断用户是否有看视频权限
        static let queAttrIsHave = "xhweb/netCourseController.do?queAttrIsHave"
    }
    
    struct PaperCatalogController {
        ///< 35. 判断用户是否有做题权限
        static let isPriviAnsQuestion = "xhweb/paperCatalogController.do?isPriviAnsQuestion"
    }
}











///< 6. 考卷类型页面数据
let URL_MOBILE_PAPER_CATALOG = "xhweb/appController.do?mobilePaperCatalog"











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





