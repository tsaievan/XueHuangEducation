//
//  XHSimpleNetCourse.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHSimpleNetCourse:  NSObject, Mappable, NSCoding {
    var courseClassId: String?
    var courseClassName: String?
    var netCourseId: String?
    var netCourseName: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        courseClassId               <- map["courseClassId"]
        courseClassName             <- map["courseClassName"]
        netCourseId                 <- map["netCourseId"]
        netCourseName               <- map["netCourseName"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        courseClassId = aDecoder.decodeObject(forKey: "courseClassId") as? String
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        netCourseId = aDecoder.decodeObject(forKey: "netCourseId") as? String
        netCourseName = aDecoder.decodeObject(forKey: "netCourseName") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courseClassId, forKey: "courseClassId")
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(netCourseId, forKey: "netCourseId")
        aCoder.encode(netCourseName, forKey: "netCourseName")
    }
}
