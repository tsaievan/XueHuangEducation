//
//  XHProfile.swift
//  XueHuangEducation
//
//  Created by tsaievan on 4/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetUserNameSuccess = ([String : Any]) -> ()
typealias XHGetUserNameFailue = (String) -> ()
typealias XHGetMyMobileNetCourseSuccess = ([XHCourseCatalog]) -> ()
typealias XHGetMyMobileNetCourseFailue = (String) -> ()

class XHProfile {
    
    /// 获取用户名的接口(根据cookie来判断用户的)
    ///
    /// - Parameters:
    ///   - success: 获取成功的回调
    ///   - failue: 获取失败的回调
    class func getMobile(success: XHGetUserNameSuccess?, failue: XHGetUserNameFailue?) {
        XHNetwork.GET(url: URL_TO_MOBILE_PERSON, params: nil, success: { (response) in
            guard let res = response as? [String : Any] else {
                return
            }
            success?(res)
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("获取用户名失败")
            }
        }
    }
    
    class func getMyMobileNetCourse(withCourseClassId courseClassId: String, success: XHGetMyMobileNetCourseSuccess?, failue: XHGetMyMobileNetCourseFailue?) {
        let params = [
            "courseClassId" : courseClassId
        ]
        XHNetwork.GET(url: URL_TO_MY_MOBILE_NET_COURSE, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
            let array = responseJson["courseCatalogs"] as? [[String : Any]] else {
                return
            }
            var tempArr = [XHCourseCatalog]()
            for catalogDict in array {
                guard let model = XHCourseCatalog(JSON: catalogDict) else {
                    continue
                }
                tempArr.append(model)
            }
            success?(tempArr)
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("获取用户名失败")
            }
        }
    }
}
