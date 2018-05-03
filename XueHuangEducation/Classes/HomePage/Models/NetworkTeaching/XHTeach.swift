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
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("数据加载失败")
            }
        }
    }
}
