//
//  XHHomePage.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit



class XHHomePage {
    
    typealias XHGetHomePageListSuccess<T: Codable> = ([[T]]) -> ()
    typealias XHGetHomePageListFailue = (String) -> ()
    
    /// 获取首页数据的逻辑
    ///
    /// - Parameters: 无参数
    ///   - success: 获取首页数据成功的回调
    ///   - failue: 获取首页数据失败的回调
    class func getHomePageList<T: Codable>(success: XHGetHomePageListSuccess<T>?, failue: XHGetHomePageListFailue?) {
        
        ///< 先从缓存里面取, 然后再发起网络请求
        XHNetwork.GET(url: URL_HOMEPAGE_LIST, params: nil, success: { (response) in
            guard let json = response as? [String : Any],
            let model = XHHomePageList(JSON: json) else {
                return
            }
            ///< 转成模型之后开始处理数据
            var mtArray = [[T]]()
            var newCatalogs = [T]()
            var titles = [T]()
            if let catalogs = model.courseCatalogs {
                for catalog in catalogs {
                    guard let level = catalog.courseClassLevel else {
                        return
                    }
                    ///< 显示的是小标题
                    if level == "0" {
                        
                        titles.append(catalog as! T)
//                        titles.append(catalog)
                    }
                    var title: String = "建工类"
                    if let titleModel = titles.first as? XHCourseCatalog {
                        title = titleModel.courseClassName ?? "建工类"
                    }
                    ///< 各个按钮的名称
                    if level == "1" {
                        catalog.customName = title
                        newCatalogs.append(catalog as! T)
                    }
                }
                mtArray.append(newCatalogs)
            }
            var newRecomNetCourses = [T]()
            if let recomNetCourses = model.isRecomNetCourse {
                if let first = recomNetCourses.first {
                    first.catalogName = "推荐课程"
                }
                if recomNetCourses.count >= 4 {
                    for (index, recom) in recomNetCourses.enumerated() {
                        newRecomNetCourses.append(recom as! T)
                        if index >= 3 {
                            break
                        }
                    }
                    mtArray.append(newRecomNetCourses)
                }
            }
            var newHotNetCourses = [T]()
            if let hotNetCourses = model.hotNetCourse {
                if let first = hotNetCourses.first {
                    first.catalogName = "热门课程"
                }
                if hotNetCourses.count >= 4 {
                    for (index, hot) in hotNetCourses.enumerated() {
                        newHotNetCourses.append(hot as! T)
                        if index >= 3 {
                            break
                        }
                    }
                    mtArray.append(newHotNetCourses)
                }
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
