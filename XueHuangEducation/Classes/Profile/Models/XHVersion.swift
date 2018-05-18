//
//  XHVersion.swift
//  XueHuangEducation
//
//  Created by tsaievan on 18/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHVersion: NSObject, Mappable, NSCoding {
    
    ///< 结果是否有最新版本
    var result: Bool?
    ///< 信息
    var msg: String?
    ///< app的链接地址
    // FIXME: - 苹果的跳转地址得单独配, 或者根据参数来决定
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result   <- map["result"]
        msg      <- map["msg"]
        url      <- map["url"]
        
    }
    required init?(coder aDecoder: NSCoder) {
        result = aDecoder.decodeObject(forKey: "result") as? Bool
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(result, forKey: "result")
        aCoder.encode(result, forKey: "msg")
        aCoder.encode(result, forKey: "url")
    }
    
}
