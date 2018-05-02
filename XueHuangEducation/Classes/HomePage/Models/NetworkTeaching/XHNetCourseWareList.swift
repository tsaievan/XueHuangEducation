//
//  XHNetCourseWareList.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHNetCourseWareList: NSObject, Mappable, NSCoding {
    var courseClassName: String?
    var netCoursewares: [XHNetCourseWare]?
    var nickname: Int64?
    var netCourseId: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        courseClassName           <- map["courseClassName"]
        netCoursewares            <- map["netCoursewares"]
        nickname                  <- map["nickname"]
        netCourseId               <- map["netCourseId"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        netCoursewares = aDecoder.decodeObject(forKey: "netCoursewares") as? [XHNetCourseWare]
        nickname = aDecoder.decodeObject(forKey: "nickname") as? Int64
        netCourseId = aDecoder.decodeObject(forKey: "netCourseId") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(netCoursewares, forKey: "netCoursewares")
        aCoder.encode(nickname, forKey: "nickname")
        aCoder.encode(netCourseId, forKey: "netCourseId")
    }
}
