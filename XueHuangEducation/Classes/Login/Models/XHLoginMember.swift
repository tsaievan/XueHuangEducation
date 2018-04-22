//
//  XHLoginMember.swift
//  XueHuangEducation
//
//  Created by tsaievan on 22/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

struct XHCreatTime {
    var date: Int16?
    var day: Int16?
    var hours: Int16?
    var minutes: Int16?
    var month: Int16?
    var seconds: Int16?
    var time: TimeInterval?
    var timezoneOffset: Int?
    var year: Int?
}

class XHLoginMember: NSObject, Mappable {
    ///< 账户名
    var accounts: String?
    ///< 地区
    var area: String?
    ///< 城市
    var city: String?
    ///< 公司
    var company: String?
    ///< 创建时间
    var createDate: XHCreatTime?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        accounts     <- map["accounts"]
        area         <- map["area"]
        city         <- map["city"]
        company      <- map["company"]
        createDate   <- map["createDate"]
        
    }
}
