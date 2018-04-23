//
//  XHHomePageList.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHHomePageList: NSObject, Mappable {
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
}
