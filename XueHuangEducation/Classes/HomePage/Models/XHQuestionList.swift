//
//  XHQuestionList.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHQuestionList: NSObject, Mappable, NSCoding {
    
    var sCourseCatalogs: [XHCourseCatalog]?
    var sfCouresCatalog: XHCourseCatalog?
    var items: [XHCourseCatalog]?
    var courseClassName: String?
    var courseClassId: String?
    var enterType: String?
    var actionType: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        sCourseCatalogs                  <- map["sCourseCatalogs"]
        courseClassId                    <- map["courseClassId"]
        courseClassName                  <- map["courseClassName"]
        sfCouresCatalog                  <- map["sfCouresCatalog"]
        items                            <- map["items"]
        enterType                        <- map["enterType"]
        actionType                       <- map["actionType"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        sCourseCatalogs = aDecoder.decodeObject(forKey: "sCourseCatalogs") as? [XHCourseCatalog]
        courseClassId = aDecoder.decodeObject(forKey: "courseClassId") as? String
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        sfCouresCatalog = aDecoder.decodeObject(forKey: "sfCouresCatalog") as? XHCourseCatalog
        items = aDecoder.decodeObject(forKey: "items") as? [XHCourseCatalog]
        enterType = aDecoder.decodeObject(forKey: "enterType") as? String
        actionType = aDecoder.decodeObject(forKey: "actionType") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sCourseCatalogs, forKey: "sCourseCatalogs")
        aCoder.encode(courseClassId, forKey: "courseClassId")
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(sfCouresCatalog, forKey: "sfCouresCatalog")
        aCoder.encode(items, forKey: "items")
        aCoder.encode(enterType, forKey: "enterType")
        aCoder.encode(actionType, forKey: "actionType")
    }

}
