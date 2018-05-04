//
//  XHIsAllowedAnswer.swift
//  XueHuangEducation
//
//  Created by tsaievan on 4/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHIsAllowedAnswer: Mappable {
    
    var success: Bool?
    var msg: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success                <- map["success"]
        msg                    <- map["msg"]
    }
}
