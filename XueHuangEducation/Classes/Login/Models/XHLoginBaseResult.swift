//
//  XHLoginBaseResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 22/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHLoginBaseResult: NSObject, Mappable, NSCoding {
    required init?(coder aDecoder: NSCoder) {
        Url = aDecoder.decodeObject(forKey: "Url") as? String
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        states = aDecoder.decodeObject(forKey: "states") as? Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Url, forKey: "Url")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(states, forKey: "states")
    }
    
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
