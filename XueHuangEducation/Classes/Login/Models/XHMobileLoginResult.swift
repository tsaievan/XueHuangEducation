//
//  XHMobileLoginResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHMobileLoginResult: XHResult{
    ///< 失败时, 该字段有值
    var message: String?
    
    var member: XHLoginMember?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        message     <- map["message"]
        member      <- map["member"]
    }
}
