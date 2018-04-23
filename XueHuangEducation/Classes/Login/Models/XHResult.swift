//
//  XHResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHResult: NSObject, Mappable, NSCoding {
    ///< 成功: ok
    var result: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        result      <- map["result"]
    }
    required init?(coder aDecoder: NSCoder) {
        result = aDecoder.decodeObject(forKey: "result") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(result, forKey: "result")
    }
}
