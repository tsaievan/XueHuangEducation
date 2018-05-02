//
//  XHPaperType.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHPaperType: XHRoutine {
    var createBy: String?
    var paperTypeName: String?
    var remark: String?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        createBy                 <- map["createBy"]
        paperTypeName            <- map["paperTypeName"]
        remark                   <- map["remark"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createBy = aDecoder.decodeObject(forKey: "createBy") as? String
        paperTypeName = aDecoder.decodeObject(forKey: "paperTypeName") as? String
        remark = aDecoder.decodeObject(forKey: "remark") as? String
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(createBy, forKey: "createBy")
        aCoder.encode(paperTypeName, forKey: "paperTypeName")
        aCoder.encode(remark, forKey: "remark")
    }
}
