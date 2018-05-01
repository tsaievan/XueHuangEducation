//
//  XHPaper.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHPaper: XHRoutine {
    var courseClassId: String?
    var createBy: String?
    var paperName: String?
    var paperTypeId: String?
    var remark: String?
    
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        courseClassId                 <- map["courseClassId"]
        createBy                      <- map["createBy"]
        paperName                     <- map["paperName"]
        paperTypeId                   <- map["paperTypeId"]
        remark                        <- map["remark"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        courseClassId = aDecoder.decodeObject(forKey: "courseClassId") as? String
        createBy = aDecoder.decodeObject(forKey: "createBy") as? String
        paperName = aDecoder.decodeObject(forKey: "paperName") as? String
        paperTypeId = aDecoder.decodeObject(forKey: "paperTypeId") as? String
        remark = aDecoder.decodeObject(forKey: "remark") as? String
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(courseClassId, forKey: "courseClassId")
        aCoder.encode(createBy, forKey: "createBy")
        aCoder.encode(paperName, forKey: "paperName")
        aCoder.encode(paperTypeId, forKey: "paperTypeId")
        aCoder.encode(remark, forKey: "remark")
    }

}
