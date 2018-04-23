//
//  XHHomePage.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetHomePageListSuccess = ([[Any]]) -> ()
typealias XHGetHomePageListFailue = (String) -> ()

class XHHomePage {
    
    /// 获取首页数据的逻辑
    ///
    /// - Parameters: 无参数
    ///   - success: 获取首页数据成功的回调
    ///   - failue: 获取首页数据失败的回调
    class func getHomePageList(success: XHGetHomePageListSuccess?, failue: XHGetHomePageListFailue?) {
        XHNetwork.GET(url: URL_HOMEPAGE_LIST, params: nil, success: { (response) in
            guard let json = response as? [String : Any],
            let model = XHHomePageList(JSON: json) else {
                return
            }
            var mtArray = [[Any]]()
            if let catalog = model.courseCatalogs {
                mtArray.append(catalog)
            }
            if let recomNetCourse = model.isRecomNetCourse {
                mtArray.append(recomNetCourse)
            }
            if let hotNetCourse = model.hotNetCourse {
                mtArray.append(hotNetCourse)
            }
            success?(mtArray)
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
