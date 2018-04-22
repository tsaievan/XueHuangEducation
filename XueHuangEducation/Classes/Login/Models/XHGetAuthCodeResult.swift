//
//  XHGetAuthCodeResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHGetAuthCodeResult: Mappable {
    ///< 成功
    ///< 成功: 1
    var success: Int?
    
    var msg: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        msg     <- map["msg"]
    }
}
