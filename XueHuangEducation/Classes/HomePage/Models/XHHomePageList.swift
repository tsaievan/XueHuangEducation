//
//  XHHomePageList.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHHomePageList: NSObject, Mappable, NSCoding {
    var courseCatalogs: [XHCourseCatalog]?
    var isRecomNetCourse: [XHNetCourse]?
    var hotNetCourse: [XHNetCourse]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        courseCatalogs         <- map["courseCatalogs"]
        isRecomNetCourse       <- map["isRecomNetCourse"]
        hotNetCourse           <- map["hotNetCourse"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        courseCatalogs = aDecoder.decodeObject(forKey: "courseCatalogs") as? [XHCourseCatalog]
        isRecomNetCourse = aDecoder.decodeObject(forKey: "isRecomNetCourse") as? [XHNetCourse]
        hotNetCourse = aDecoder.decodeObject(forKey: "hotNetCourse") as? [XHNetCourse]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courseCatalogs, forKey: "courseCatalogs")
        aCoder.encode(isRecomNetCourse, forKey: "isRecomNetCourse")
        aCoder.encode(hotNetCourse, forKey: "hotNetCourse")
    }
}
