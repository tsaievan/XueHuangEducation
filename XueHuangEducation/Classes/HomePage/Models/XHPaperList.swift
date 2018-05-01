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
    
    var courseClassName: String?
    var courseClassId: String?
    var imgAddr: String?
    var netCourses: [XHSimpleNetCourse]?
    var courseCatalogs: [XHCourseCatalog]?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        courseClassName          <- map["courseClassName"]
        courseClassId            <- map["courseClassId"]
        imgAddr                  <- map["imgAddr"]
        netCourses               <- map["netCourses"]
        courseCatalogs           <- map["courseCatalogs"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        courseClassId = aDecoder.decodeObject(forKey: "courseClassId") as? String
        imgAddr = aDecoder.decodeObject(forKey: "imgAddr") as? String
        netCourses = aDecoder.decodeObject(forKey: "netCourses") as? [XHSimpleNetCourse]
        courseCatalogs = aDecoder.decodeObject(forKey: "courseCatalogs") as? [XHCourseCatalog]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(courseClassId, forKey: "courseClassId")
        aCoder.encode(imgAddr, forKey: "imgAddr")
        aCoder.encode(netCourses, forKey: "netCourses")
        aCoder.encode(courseCatalogs, forKey: "courseCatalogs")
    }

}
