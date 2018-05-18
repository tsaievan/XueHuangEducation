//
//  XHVersion.swift
//  XueHuangEducation
//
//  Created by tsaievan on 18/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHVersion: XHResult {
    ///< 信息
    var msg: String?
    ///< app的链接地址
    // FIXME: - 苹果的跳转地址得单独配, 或者根据参数来决定
    var url: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        msg      <- map["msg"]
        url      <- map["url"]
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(result, forKey: "result")
    }
    
}
