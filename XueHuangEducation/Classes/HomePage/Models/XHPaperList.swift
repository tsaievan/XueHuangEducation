//
//  XHPaperList.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHPaperList: NSObject, Mappable, NSCoding {
    
    var sCourseCatalogs: [XHCourseCatalog]?
    var courseClassId: String?
    var courseClassName: String?
    var sfCouresCatalog: XHCourseCatalog?
    var tCourseCatalogs: [XHCourseCatalog]?
    var paperTypes: [XHPaperType]?
    var paperLists: [XHPaper]?

    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        sCourseCatalogs                  <- map["sCourseCatalogs"]
        courseClassId                    <- map["courseClassId"]
        courseClassName                  <- map["courseClassName"]
        sfCouresCatalog                  <- map["sfCouresCatalog"]
        tCourseCatalogs                  <- map["tCourseCatalogs"]
        paperTypes                       <- map["paperTypes"]
        paperLists                       <- map["paperLists"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        sCourseCatalogs = aDecoder.decodeObject(forKey: "sCourseCatalogs") as? [XHCourseCatalog]
        courseClassId = aDecoder.decodeObject(forKey: "courseClassId") as? String
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        sfCouresCatalog = aDecoder.decodeObject(forKey: "sfCouresCatalog") as? XHCourseCatalog
        tCourseCatalogs = aDecoder.decodeObject(forKey: "tCourseCatalogs") as? [XHCourseCatalog]
        paperTypes = aDecoder.decodeObject(forKey: "paperTypes") as? [XHPaperType]
        paperLists = aDecoder.decodeObject(forKey: "paperLists") as? [XHPaper]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sCourseCatalogs, forKey: "sCourseCatalogs")
        aCoder.encode(courseClassId, forKey: "courseClassId")
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(sfCouresCatalog, forKey: "sfCouresCatalog")
        aCoder.encode(tCourseCatalogs, forKey: "tCourseCatalogs")
        aCoder.encode(paperTypes, forKey: "paperTypes")
        aCoder.encode(paperLists, forKey: "paperLists")
    }
}
