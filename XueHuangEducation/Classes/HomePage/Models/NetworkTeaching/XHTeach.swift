//
//  XHTeach.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetNetcoursewareSuccess = ([XHNetCourseWare]) -> ()
typealias XHGetNetcoursewareFailue = (String) -> ()
typealias XHIsAllowedWatchVideoSuccess = (XHIsAllowedWatch) -> ()
typealias XHIsAllowedWatchVideoFailue = (String) -> ()

/// 附件的类型
///
/// - file: 文件
/// - table: 图标
/// - video: 视频
enum XHAttchmentType: Int {
    case file = 0
    case table = 1
    case video = 2
}

class XHTeach {
    
    /// 获取网校讲题课件页面的接口
    ///
    /// - Parameters:
    ///   - courseName: 课程名称
    ///   - courseId: 课程id
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func getNetcourseware(withCourseName courseName: String, courseId: String, success: XHGetNetcoursewareSuccess?, failue: XHGetNetcoursewareFailue?) {
        let params = [
            "netCourseId" : courseId,
            "courseClassName" : courseName,
            ]
        XHNetwork.GET(url: URL_TO_NET_COURSE_WARE, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHNetCourseWareList(JSON: responseJson),
                let courses = model.netCoursewares else {
                    return
            }
            success?(courses)
        }) { (error) in
            if error.code == NSURLErrorNotConnectedToInternet {
                failue?("网络连接失败, 请检查网络")
            }else {
                failue?("数据加载失败")
            }
        }
    }
    
    class func isAllowedWatchVideo(withCourseId courseId: String, success: XHIsAllowedWatchVideoSuccess?, failue: XHIsAllowedWatchVideoFailue?) {
        let params = [
            "id" : courseId,
            "attrType" : XHAttchmentType.table.rawValue
            ] as [String : Any]
        XHNetwork.GET(url: URL_IS_ALLOWED_WATCH_VIDEO, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHIsAllowedWatch(JSON: responseJson) else {
                    return
            }
            
            success?(model)
        }) { (error) in
            if error.code == NSURLErrorNotConnectedToInternet {
                failue?("网络连接失败, 请检查网络")
            }else {
                failue?("数据加载失败")
            }
        }
    }
}
