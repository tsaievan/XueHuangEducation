//
//  XHLoginBaseResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 22/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHLoginBaseResult: NSObject, Mappable {
    ///< Url
    var Url: String?
    ///< 状态信息 `ok`等
    var msg: String?
    ///< 状态
    var states: Bool?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        Url     <- map["Url"]
        msg     <- map["msg"]
        states  <- map["states"]
    }
}
