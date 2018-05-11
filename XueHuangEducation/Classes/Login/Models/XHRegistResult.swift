//
//  XHRegistResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 6/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHRegistResult: Mappable {
    ///< 成功: ok
    ///< 失败: error
    var result: XHRegistResult?
    
    var message: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        result      <- map["result"]
        message     <- map["message"]
    }

}
