//
//  XHHomePageList.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

enum XHHomePageListCodingKeys: CodingKey {
    case courseCatalogs
    case isRecomNetCourse
    case hotNetCourse
}

class XHHomePageList: XHBaseModel {
    
    var courseCatalogs: [XHCourseCatalog]?
    var isRecomNetCourse: [XHNetCourse]?
    var hotNetCourse: [XHNetCourse]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        courseCatalogs         <- map["courseCatalogs"]
        isRecomNetCourse       <- map["isRecomNetCourse"]
        hotNetCourse           <- map["hotNetCourse"]
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let vaules = try? decoder.container(keyedBy: XHHomePageListCodingKeys.self)
        courseCatalogs = try vaules?.decode([XHCourseCatalog].self, forKey: .courseCatalogs)
        isRecomNetCourse = try vaules?.decode([XHNetCourse].self, forKey: .isRecomNetCourse)
        hotNetCourse = try vaules?.decode([XHNetCourse].self, forKey: .hotNetCourse)
    }
    
    override func encode(to encoder: Encoder) throws {
        try? super.encode(to: encoder)
        var homePageList = encoder.container(keyedBy: XHHomePageListCodingKeys.self)
        try homePageList.encode(courseCatalogs, forKey: .courseCatalogs)
        try homePageList.encode(isRecomNetCourse, forKey: .isRecomNetCourse)
        try homePageList.encode(hotNetCourse, forKey: .hotNetCourse)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        courseCatalogs = aDecoder.decodeObject(forKey: "courseCatalogs") as? [XHCourseCatalog]
        isRecomNetCourse = aDecoder.decodeObject(forKey: "isRecomNetCourse") as? [XHNetCourse]
        hotNetCourse = aDecoder.decodeObject(forKey: "hotNetCourse") as? [XHNetCourse]
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(courseCatalogs, forKey: "courseCatalogs")
        aCoder.encode(isRecomNetCourse, forKey: "isRecomNetCourse")
        aCoder.encode(hotNetCourse, forKey: "courseCatalogs")
    }
}
