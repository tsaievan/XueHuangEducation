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
typealias XHGetTeachCourseListSuccess = ([XHCourseCatalog], String?) -> ()
typealias XHGetTeachCourseListFailue = (String) -> ()
typealias XHGetPaperListSuccess = ([XHCourseCatalog], String?) -> ()
typealias XHGetPaperListFailue = (String) -> ()
typealias XHGetQuestionListSuccess = ([XHCourseCatalog], String?) -> ()
typealias XHGetQuestionListFailue = (String) -> ()

enum XHQuestionEnterType: String {
    case make = "1"
    case teach = "2"
    case answer = "3"
    case download = "4"
    case broadcast = "5"
}

enum XHHomePageShowTileType: String {
    case detail = "0"
    case button = "1"
}

extension String {
    struct HomePage {
        static let construct = "建工类"
        static let recommend = "推荐课程"
        static let hot = "热门课程"
        static let all = "全部"
    }
}

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
            ///< 转成模型之后开始处理数据
            var mtArray = [[Any]]()
            var newCatalogs = [XHCourseCatalog]()
            var titles = [XHCourseCatalog]()
            if let catalogs = model.courseCatalogs {
                for catalog in catalogs {
                    guard let level = catalog.courseClassLevel else {
                        return
                    }
                    ///< 显示的是小标题
                    if level == XHHomePageShowTileType.detail.rawValue {
                        titles.append(catalog)
                    }
                    var title: String = String.HomePage.construct
                    if let titleModel = titles.first {
                        title = titleModel.courseClassName ?? String.HomePage.construct
                    }
                    ///< 各个按钮的名称
                    if level == XHHomePageShowTileType.button.rawValue {
                        catalog.customName = title
                        newCatalogs.append(catalog)
                    }
                }
                mtArray.append(newCatalogs)
            }
            var newRecomNetCourses = [XHNetCourse]()
            if let recomNetCourses = model.isRecomNetCourse {
                if let first = recomNetCourses.first {
                    first.catalogName = String.HomePage.recommend
                }
                if recomNetCourses.count >= 4 {
                    for (index, recom) in recomNetCourses.enumerated() {
                        newRecomNetCourses.append(recom)
                        if index >= 3 {
                            break
                        }
                    }
                    mtArray.append(newRecomNetCourses)
                }else {
                    mtArray.append(recomNetCourses)
                }
            }
            var newHotNetCourses = [XHNetCourse]()
            if let hotNetCourses = model.hotNetCourse {
                if let first = hotNetCourses.first {
                    first.catalogName = String.HomePage.hot
                }
                if hotNetCourses.count >= 4 {
                    for (index, hot) in hotNetCourses.enumerated() {
                        newHotNetCourses.append(hot)
                        if index >= 3 {
                            break
                        }
                    }
                    mtArray.append(newHotNetCourses)
                }else {
                    mtArray.append(hotNetCourses)
                }
            }
            success?(mtArray)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?(XHNetworkError.Desription.commonError)
            }
        }
    }
    
    /// 获取讲题页面的数据
    ///
    /// - Parameters:
    ///   - withCourseName: 课程名称
    ///   - courseId: 课程Id
    ///   - success: 获取数据成功的回调
    ///   - failue: 获取数据失败的回调
    class func getTeachCourseList(withCourseName: String, courseId: String, success: XHGetTeachCourseListSuccess?, failue: XHGetTeachCourseListFailue?) {
        let params = [
            "courseClassName" : withCourseName,
            "courseClassId" : courseId
        ]
        XHNetwork.GET(url: URL_TO_MOBILE_NET_COURSE, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHThemeList(JSON: responseJson) else {
                    return
            }
            
            ///< 在这里进行数据处理
            guard let catalogs = model.courseCatalogs,
                let netCourses = model.netCourses else {
                    return
            }
            var fatherArray = [XHCourseCatalog]()
            for catalog in catalogs {
                guard let name = catalog.courseClassName else {
                    continue
                }
                var sonArray = [XHSimpleNetCourse]()
                for net in netCourses {
                    guard let netName = net.courseClassName else {
                        continue
                    }
                    if netName == name {
                        sonArray.append(net)
                    }
                }
                catalog.netCourses = sonArray
                fatherArray.append(catalog)
            }
            success?(fatherArray, model.imgAddr)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?(XHNetworkError.Desription.commonError)
            }
        }
    }
    
    /// 获取考卷列表数据
    ///
    /// - Parameters:
    ///   - courseId: 课程id
    ///   - success: 获取考卷列表成功的回调
    ///   - failue: 获取考卷列表失败的回调
    class func getPaperList(withCourseClassId courseId: String, success: XHGetPaperListSuccess?, failue: XHGetPaperListFailue?) {
        let params = [
            "curCourseClassId" : courseId
        ]
        XHNetwork.GET(url: URL_TO_MOBILE_PAPER_LIST, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHPaperList(JSON: responseJson) else {
                    return
            }
            ///< 同样要进行数据处理(貌似更复杂)
            guard let catalogs = model.tCourseCatalogs,
                let paperList = model.paperLists,
                let types = model.paperTypes else {
                    return
            }
            var typeDict = [String : String]()
            for type in types {
                guard let name = type.paperTypeName,
                    let id = type.id else {
                        continue
                }
                typeDict[id] = name
            }
            var fatherArray = [XHCourseCatalog]()
            for catalog in catalogs {
                guard let id = catalog.id else {
                    continue
                }
                var sonArray = [XHPaper]()
                for paper in paperList {
                    guard let paperId = paper.courseClassId,
                        let typeId = paper.paperTypeId else {
                            continue
                    }
                    if paperId == id {
                        if typeDict.keys.contains(typeId) {
                            paper.typeName = typeDict[typeId]
                            sonArray.append(paper)
                        }
                    }
                }
                catalog.paperLists = sonArray
                fatherArray.append(catalog)
            }
            success?(fatherArray, model.courseClassName)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?(XHNetworkError.Desription.commonError)
            }
        }
    }
    
    /// 获取在线答疑主页面列表的方法
    ///
    /// - Parameters:
    ///   - enterType: 按钮类型
    ///   - courseName: 课程名称
    ///   - courseId: 课程id
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func getQuestionList(withEnterType enterType: XHQuestionEnterType, courseName: String, courseId: String, success: XHGetQuestionListSuccess?, failue: XHGetQuestionListFailue?) {
        let params = [
            "enterType" : enterType.rawValue,
            "courseClassName" : courseName,
            "courseClassId" : courseId,
            "actionType" : XHActionType.all.rawValue
        ]
        XHNetwork.GET(url: URL_TO_QUESTION_LIST, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHQuestionList(JSON: responseJson),
                let total = model.sfCouresCatalog,
                let questions = model.items else {
                    return
            }
            total.queCount = model.totalCount
            let originalName = total.courseClassName
            total.courseClassName = String.HomePage.all
            var array = questions
            array.insert(total, at: 0)
            success?(array, originalName)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?(XHNetworkError.Desription.commonError)
            }
        }
    }
}
