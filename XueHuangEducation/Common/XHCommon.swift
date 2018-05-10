//
//  XHCommon.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//
import UIKit


// MARK: - 屏幕的尺寸
struct XHSCreen {
    static let bounds = UIScreen.main.bounds
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

// MARK: - 颜色的分类
extension UIColor {
    struct Global { ///< 全局的
        static let darkGray = UIColor(hexColor: "#393A3F") ///< 深灰
        static let lightGray = UIColor(hexColor: "#DEDEE2") ///< 浅灰
        static let skyBlue = UIColor(hexColor: "#3399FF") ///< 天蓝
        static let background = UIColor(hexColor: "#F2F2F7") ///< 背景
    }
}

// MARK: - 字符串的分类
extension String {
    ///< 空字符串
    static let empty = ""
    ///< 一个点字符串
    static let point = "."
    ///< 空格
    static let space = " "
    enum Alert: String {
        case info = "信息"
        case cancel = "取消"
        case confirm = "确定"
    }
}

// MARK: - 比例
struct XHRatio {
    ///< 宽高比
    struct W_H_R {
        struct TeachViewController {}
        struct CatalogListViewController {}
        struct PlayNetCourseViewController {}
    }
}

// MARK: - cell重用标识
struct XHCellReuseIdentifier {
    struct TeachViewController {}
    struct NetCourseWareController {}
}

// MARK: - tableView的header重用标识
struct XHHeaderReuseIdentifier {
    struct TeachViewController {}
}

// MARK: - 定义一些全局的数字
extension CGFloat {
    static let tableViewMinimumHeaderHeight: CGFloat = 0.01
    static let tableViewMinimumFooterHeight: CGFloat = 0.01
    static let commonCornerRadius: CGFloat = 5.0
    static let smallCornerRadius: CGFloat = 2.0
    static let zero: CGFloat = 0.0
    
    ///< 字体大小
    struct FontSize {
        static let _12: CGFloat = 12.0
        static let _13: CGFloat = 13.0
        static let _14: CGFloat = 14.0
        static let _15: CGFloat = 15.0
        static let _16: CGFloat = 16.0
        static let _17: CGFloat = 17.0
        static let _20: CGFloat = 20.0
    }
}

extension Int {
    static let zero: Int = 0
}

// MARK: - 全局的边距
struct XHMargin {
    static let _0_5: CGFloat = 0.5
    static let _2: CGFloat = 2
    static let _5: CGFloat = 5
    static let _10: CGFloat = 10
    static let _14: CGFloat = 14
    static let _15: CGFloat = 15
    static let _20: CGFloat = 20
    static let _25: CGFloat = 25
    static let _30: CGFloat = 30
    static let _44: CGFloat = 44
    static let _60: CGFloat = 60
}


///< 全局的颜色
let COLOR_CATALOG_BUTTON_TITLE_COLOR: UIColor = UIColor(hexColor: "#333333")
let COLOR_HOMEPAGE_TIP_LABEL_COLOR: UIColor = UIColor(hexColor: "#555555")
let COLOR_HOMEPAGE_COURSE_ICON_BLUE: UIColor = UIColor(hexColor: "#27C1F4")
let COLOR_PROFILE_BUTTON_TITLE_COLOR: UIColor = UIColor(hexColor: "#333333")

let COLOR_PAPER_CELL_LIGHT_GRAY: UIColor = UIColor(hexColor: "#F9F9F9")
let COLOR_QUESTION_COUNT_LABEL_LIGHT_GRAY: UIColor = UIColor(hexColor: "#999999")

///< 控件的颜色
let COLOR_BUTTON_BORDER_GETAUTH_DARKGRAY = UIColor(hexColor: "#D2D2D2")

///< 经常用的数字0
let GLOBAL_ZERO: CGFloat = 0.0

///< cell的identifier
let CELL_IDENTIFIER_HOMEPAGE_CATALOG = "CELL_IDENTIFIER_HOMEPAGE_CATALOG"
let CELL_IDENTIFIER_HOMEPAGE_NETCOURSE = "CELL_IDENTIFIER_HOMEPAGE_NETCOURSE"
let CELL_IDENTIFIER_NETCOURSE_DETAIL = "CELL_IDENTIFIER_NETCOURSE_DETAIL"
let CELL_IDENTIFIER_PAPER_DETAIL = "CELL_IDENTIFIER_PAPER_DETAIL"
let CELL_IDENTIFIER_QUESTION_LIST = "CELL_IDENTIFIER_QUESTION_LIST"
let CELL_IDENTIFIER_NETCOURSE_WARE = "CELL_IDENTIFIER_NETCOURSE_WARE"
let CELL_IDENTIFIER_PAPER_LIST = "CELL_IDENTIFIER_PAPER_LIST"
let HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW = "HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW"
let HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW = "HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW"
let HEADER_TITLE_VIEW_IDENTIFIER_PAPER_TABLEVIEW = "HEADER_TITLE_VIEW_IDENTIFIER_PAPER_TABLEVIEW"

let TOP_EDGE_AJUSTED: CGFloat = UIDevice.iPhoneX ? 84 : 64


///< 首页
let SEPERATOR_LINE_HEIGHT: CGFloat = 1.5 ///< 分割线高度

///< 全局的XHLoadingView的宽高
let HEIGHT_GLOBAL_LOADING_VIEW: CGFloat = 22.0
let WIDTH_GLOBAL_LOADING_VIEW: CGFloat = 22.0



///< 首页
let HEIGHT_HOMEPAGE_CATALOG_BUTTON: CGFloat = 30
let RADIUS_HOMEPAGE_CATALOG_BUTTON: CGFloat = 15

///< 获取验证码的最大时间 (10min)
let TIME_INTERVAL_MAX_GET_AUTH_CODE: TimeInterval = Double(MAXFLOAT)


///< 事件的名称
let EVENT_CLICK_CATALOG_BUTTON = "EVENT_CLICK_CATALOG_BUTTON"
let EVENT_CLICK_COURSE_BUTTON = "EVENT_CLICK_COURSE_BUTTON"
let MODEL_CLICK_CATALOG_BUTTON = "MODEL_CLICK_CATALOG_BUTTON"
let MODEL_CLICK_COURSE_BUTTON = "MODEL_CLICK_COURSE_BUTTON"
let CELL_FOR_COURSE_BUTTON = "CELL_FOR_COURSE_BUTTON"

let KEY_DOWNLOAD_HOME_PAGE_SUCCESS_DATA = "KEY_DOWNLOAD_HOME_PAGE_SUCCESS_DATA"
let KEY_DOWNLOAD_HOME_PAGE_FAILUE_DATA = "KEY_DOWNLOAD_HOME_PAGE_FAILUE_DATA"

let XH_DEFAULT_DISK_CACHE = "XH_DEFAULT_DISK_CACHE"
let KEY_DOWNLOAD_HOME_PAGE_DATA_FOR_YYCACHE = "KEY_DOWNLOAD_HOME_PAGE_DATA_FOR_YYCACHE"


// MARK: - 通知名的分类
extension Notification.Name {
    ///< 下载首页数据成功/失败的通知
    public struct XHDownloadHomePageData {
        static let success = Notification.Name(rawValue: "XHDownloadHomePageDataSuccess")
        static let failue = Notification.Name(rawValue: "XHDownloadHomePageDataFailue")
    }
}
