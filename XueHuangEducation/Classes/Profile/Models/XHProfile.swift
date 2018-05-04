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

class XHProfile {
    
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
}
