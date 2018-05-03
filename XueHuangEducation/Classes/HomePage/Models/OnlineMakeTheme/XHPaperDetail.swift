//
//  XHPaperDetail.swift
//  XueHuangEducation
//
//  Created by tsaievan on 3/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHPaperDetail: NSObject, Mappable, NSCoding {
    var id: String?
    var open: String?
    var num: Int?
    var Count: Int?
    var paperId: String?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id                         <- map["id"]
        open                       <- map["open"]
        num                        <- map["num"]
        Count                      <- map["Count"]
        paperId                    <- map["paperId"]
        name                       <- map["name"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        open = aDecoder.decodeObject(forKey: "open") as? String
        num = aDecoder.decodeObject(forKey: "num") as? Int
        Count = aDecoder.decodeObject(forKey: "Count") as? Int
        paperId = aDecoder.decodeObject(forKey: "paperId") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(open, forKey: "open")
        aCoder.encode(num, forKey: "num")
        aCoder.encode(Count, forKey: "Count")
        aCoder.encode(paperId, forKey: "paperId")
        aCoder.encode(name, forKey: "name")
    }
}

