//
//  XHMobilePaper.swift
//  XueHuangEducation
//
//  Created by tsaievan on 3/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetMobilePaperCatalogSuccess = ([XHPaperDetail]) -> ()
typealias XHGetMobilePaperCatalogFailue = (String) -> ()
typealias XHIsAllowedAnswerQuestionSuccess = (XHIsAllowedAnswer) -> ()
typealias XHIsAllowedAnswerQuestionFailue = (String) -> ()
typealias XHhasQuestionLogSuccess = (Bool) -> ()
typealias XHhasQuestionLogFailue = (String) -> ()

class XHMobilePaper {

    /// 获取网校讲题课件页面的接口
    ///
    /// - Parameters:
    ///   - courseName: 课程名称
    ///   - courseId: 课程id
    ///   - success: 成功的回调
    ///   - failue: 失败的回调
    class func getMobilePaperCatalog(withPaperId paperId: String, success: XHGetMobilePaperCatalogSuccess?, failue: XHGetMobilePaperCatalogFailue?) {
        let params = [
            "paperId" : paperId,
            "isFree" : "",
            ]
        XHNetwork.GET(url: URL_MOBILE_PAPER_CATALOG_NEW, params: params, success: { (response) in
            guard let responseJson = response as? [[String : Any]] else {
                return
            }
            var array = [XHPaperDetail]()
            for dict in responseJson {
                guard let model = XHPaperDetail(JSON: dict) else {
                    continue
                }
                array.append(model)
            }
            success?(array)
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("数据加载失败")
            }
        }
    }
    
    /// 是否有做题资格的接口
    ///
    /// - Parameters:
    ///   - forPaperId: 考卷id
    ///   - paperCatalogId: 考卷的分类id
    ///   - success: 调用成功的回调
    ///   - failue: 调用失败的回调
    class func isAllowedAnswerQuestion(forPaperId: String, paperCatalogId: String, success: XHIsAllowedAnswerQuestionSuccess?, failue: XHIsAllowedAnswerQuestionFailue?) {
        let params = [
            "paperId" : forPaperId,
            "paperCatalogId" : paperCatalogId
        ]
        XHNetwork.GET(url: URL_IS_ALLOWED_ANSWER_QUESTION, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
            let model = XHIsAllowedAnswer(JSON: responseJson) else {
                return
            }
            success?(model)
        }) { (error) in
            let err = error as NSError
            if err.code == -1009 {
                failue?("网络连接失败")
            }else {
                failue?("数据加载失败")
            }
        }
    }
    ///< URL_HAS_QUESTION_LOG
    class func hasQuestionLog(forPaperId: String, paperCatalogId: String, success: XHhasQuestionLogSuccess?, failue: XHhasQuestionLogFailue?) {
        let params = [
            "paperId" : forPaperId,
            "paperCatalogId" : paperCatalogId
        ]
        XHNetwork.GET(url: URL_HAS_QUESTION_LOG, params: params, success: { (response) in
            guard let responseJson = response as? [String : Any],
                let hasQuestionLog = responseJson["success"] as? Bool else {
                    return
            }
            success?(hasQuestionLog)
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
