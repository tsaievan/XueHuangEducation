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
typealias XHGetMyMobileNetCourseSuccess = ([XHCourseCatalog], XHThemeList) -> ()
typealias XHGetMyMobileNetCourseFailue = (NSError) -> ()
typealias XHGetMyMobilePaperListSuccess = ([XHCourseCatalog], XHPaperList) -> ()
typealias XHGetMyMobilePaperListFailue = (NSError) -> ()
typealias XHGetMyMobieQuestionListSuccess = ([XHCourseCatalog], XHQuestionList) -> ()
typealias XHGetMyMobieQuestionListFailue = (NSError) -> ()
typealias XHUpgradeSuccess = (Any) -> ()
typealias XHUpgradeFailue = (NSError) -> ()

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
            if error.code == NSURLErrorNotConnectedToInternet {
                failue?("网络连接失败, 请检查网络")
            }else {
                failue?("获取用户名失败")
            }
        }
    }
    
    /// 获取我的讲题列表数据
    ///
    /// - Parameters:
    ///   - courseClassId: 课程的id, 第一次进入时传空
    ///   - success: 请求成功的回调
    ///   - failue: 请求失败的回调
    class func getMyMobileNetCourse(withCourseClassId courseClassId: String, success: XHGetMyMobileNetCourseSuccess?, failue: XHGetMyMobileNetCourseFailue?) {
        let params = [
            "courseClassId" : courseClassId
        ]
        XHNetwork.GET(url: URL_TO_MY_MOBILE_NET_COURSE, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHThemeList(JSON: responseJson) else {
                    return
            }
            
            ///< 在这里进行数据处理
            guard let catalogs = model.courseCatalogs,
                let netCourses = model.netCourses else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "暂无我的讲题列表相关数据"])
                    failue?(error)
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
            // FIXME: - 数据还需处理
            ///< 这个地方貌似还要传一个courseClassName
            success?(fatherArray, model)
        }) { (error) in
            failue?(error)
        }
    }
    
    /// 获取考卷列表的接口
    ///
    /// - Parameters:
    ///   - courseClassId: 课程id
    ///   - success: 请求成功的回调
    ///   - failue: 请求失败的回调
    class func getMyMobiePaperList(withCourseClassId courseClassId: String, success: XHGetMyMobilePaperListSuccess?, failue: XHGetMyMobilePaperListFailue?) {
        let params = [
            "courseClassId" : courseClassId
        ]
        XHNetwork.GET(url: URL_TO_MY_MOBIE_PAPER_LIST, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHPaperList(JSON: responseJson) else {
                    return
            }
            ///< 同样要进行数据处理(貌似更复杂)
            guard let catalogs = model.tCourseCatalogs,
                let paperList = model.paperLists,
                let types = model.paperTypes else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "暂无我的答题列表相关数据"])
                    failue?(error)
                    return
            }
            var typeDict = [String : String]()
            for type in types {
                guard let name = type.paperTypeName,
                    let id = type.paperTypeId else {
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
            success?(fatherArray, model)
        }) { (error) in
            failue?(error)
        }
    }
    
    
    class func getMyMobieQuestionList(withEnterType enterType: XHQuestionEnterType, courseClassId: String, success: XHGetMyMobieQuestionListSuccess?, failue: XHGetMyMobieQuestionListFailue?) {
        let params = [
            "enterType" : enterType.rawValue,
            "courseClassId" : courseClassId,
            "actionType" : XHActionType.my.rawValue
        ]
        XHNetwork.GET(url: URL_TO_MY_QUESTION_LIST, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHQuestionList(JSON: responseJson),
                let questions = model.items else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "暂无我的问答列表相关数据"])
                    failue?(error)
                    return
            }
            guard let total = XHCourseCatalog(JSON: responseJson) else {
                return
            }
            total.queCount = model.totalCount
            total.courseClassName = "全部"
            total.id = courseClassId
            var array = questions
            array.insert(total, at: 0)
            success?(array, model)
        }) { (error) in
            failue?(error)
        }
    }
    
    /// 获取可用最新版本的接口
    ///
    /// - Parameters:
    ///   - version: 获取用户当前的版本号
    ///   - success: 请求数据成功的回调
    ///   - failue: 请求数据失败的回调
    class func upgrade(WithCurrentVersion version: String, success: XHUpgradeSuccess?, failue: XHUpgradeFailue?) {
        let params = [
            "versions" : version
        ]
        XHNetwork.GET(url: XHURL.AppController.upgrade, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let model = XHVersion(JSON: responseJson) else {
                    return
            }
            
        }) { (error) in
            failue?(error)
        }
    }
}
