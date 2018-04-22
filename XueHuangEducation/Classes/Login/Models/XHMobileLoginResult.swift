//
//  XHMobileLoginResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHMobileLoginResult: Mappable{
    ///< 结果
    ///< 成功: ok
    ///< 失败: error
    var result: String?
    
    ///< 失败时, 该字段有值
    var message: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        result      <- map["result"]
        message     <- map["message"]
    }
}
