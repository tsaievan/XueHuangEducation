//
//  XHCommon.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//
import UIKit

let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

///< 全局的颜色
let COLOR_GLOBAL_DARK_GRAY: UIColor = UIColor(hexColor: "#393A3F")
let COLOR_GLOBAL_BLUE: UIColor = UIColor(hexColor: "#3399FF")
let COLOR_CLOBAL_LIGHT_GRAY: UIColor = UIColor(hexColor: "#DEDEE2")
let COLOR_HOMEPAGE_BACKGROUND: UIColor = UIColor(hexColor: "#F2F2F7")
let COLOR_HOMEPAGE_CATALOG_SEPERATOR_COLOR: UIColor = UIColor(hexColor: "#EEEEEE")
let COLOR_CATALOG_BUTTON_BORDER_COLOR: UIColor = UIColor(hexColor: "#CCCCCC")
let COLOR_CATALOG_BUTTON_TITLE_COLOR: UIColor = UIColor(hexColor: "#333333")
let COLOR_HOMEPAGE_TIP_LABEL_COLOR: UIColor = UIColor(hexColor: "#555555")
let COLOR_HOMEPAGE_COURSE_ICON_BLUE: UIColor = UIColor(hexColor: "#27C1F4")


///< 全局的数字
let FONT_SIZE_13: CGFloat = 13.0
let FONT_SIZE_14: CGFloat = 14.0
let FONT_SIZE_16: CGFloat = 16.0

///< cell的identifier
let CELL_IDENTIFIER_HOMEPAGE_CATALOG = "CELL_IDENTIFIER_HOMEPAGE_CATALOG"
let CELL_IDENTIFIER_HOMEPAGE_NETCOURSE = "CELL_IDENTIFIER_HOMEPAGE_NETCOURSE"

///< 一些魔法数字, 边距等
///< 全局
let MARGIN_GLOBAL_10: CGFloat = 10
let MARGIN_GLOBAL_14: CGFloat = 14
let MARGIN_GLOBAL_15: CGFloat = 15
let MARGIN_GLOBAL_20: CGFloat = 20
let MARGIN_GLOBAL_25: CGFloat = 25
let MARGIN_GLOBAL_60: CGFloat = 60

///< 首页
let SEPERATOR_LINE_HEIGHT: CGFloat = 1.5 ///< 分割线高度



///< 首页
let HEIGHT_HOMEPAGE_CATALOG_BUTTON: CGFloat = 30
let RADIUS_HOMEPAGE_CATALOG_BUTTON: CGFloat = 15

///< 控件的颜色
let COLOR_BUTTON_BORDER_GETAUTH_DARKGRAY = UIColor(hexColor: "#D2D2D2")

///< 获取验证码的最大时间 (10min)
let TIME_INTERVAL_MAX_GET_AUTH_CODE: TimeInterval = Double(MAXFLOAT)

///< 事件的名称
let EVENT_CLICK_CATALOG_BUTTON = "EVENT_CLICK_CATALOG_BUTTON"
let EVENT_CLICK_COURSE_BUTTON = "EVENT_CLICK_COURSE_BUTTON"
let MODEL_CLICK_CATALOG_BUTTON = "MODEL_CLICK_CATALOG_BUTTON"
let MODEL_CLICK_COURSE_BUTTON = "MODEL_CLICK_COURSE_BUTTON"
let CELL_FOR_COURSE_BUTTON = "CELL_FOR_COURSE_BUTTON"

extension Notification.Name {
    ///< 下载首页数据成功/失败的通知
    public struct XHDownloadHomePageData {
        static let success = Notification.Name(rawValue: "XHDownloadHomePageDataSuccess")
        static let failue = Notification.Name(rawValue: "XHDownloadHomePageDataFailue")
    }
}

let KEY_DOWNLOAD_HOME_PAGE_SUCCESS_DATA = "KEY_DOWNLOAD_HOME_PAGE_SUCCESS_DATA"
let KEY_DOWNLOAD_HOME_PAGE_FAILUE_DATA = "KEY_DOWNLOAD_HOME_PAGE_FAILUE_DATA"

let XH_DEFAULT_DISK_CACHE = "XH_DEFAULT_DISK_CACHE"
//let XH_DEFAULT_MEMORY_CACHE = "XH_DEFAULT_MEMORY_CACHE"
let KEY_DOWNLOAD_HOME_PAGE_DATA_FOR_YYCACHE = "KEY_DOWNLOAD_HOME_PAGE_DATA_FOR_YYCACHE"


