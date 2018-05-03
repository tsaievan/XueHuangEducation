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
}
