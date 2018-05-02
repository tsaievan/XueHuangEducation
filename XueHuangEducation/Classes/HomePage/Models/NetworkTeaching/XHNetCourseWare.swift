//
//  XHNetCourseWare.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHNetCourseWare: NSObject, Mappable, NSCoding {
    var document: String?
    var netCoursewareId: String?
    var state: Int?
    var netCoursewareName: String?
    var catalogId: String?
    var teacher: String?
    var video: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        document                        <- map["document"]
        netCoursewareId                 <- map["netCoursewareId"]
        state                           <- map["state"]
        netCoursewareName               <- map["netCoursewareName"]
        catalogId                       <- map["catalogId"]
        teacher                         <- map["teacher"]
        video                           <- map["video"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        document = aDecoder.decodeObject(forKey: "document") as? String
        netCoursewareId = aDecoder.decodeObject(forKey: "netCoursewareId") as? String
        state = aDecoder.decodeObject(forKey: "state") as? Int
        netCoursewareName = aDecoder.decodeObject(forKey: "netCoursewareName") as? String
        catalogId = aDecoder.decodeObject(forKey: "catalogId") as? String
        teacher = aDecoder.decodeObject(forKey: "teacher") as? String
        video = aDecoder.decodeObject(forKey: "video") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(document, forKey: "document")
        aCoder.encode(netCoursewareId, forKey: "netCoursewareId")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(netCoursewareName, forKey: "netCoursewareName")
        aCoder.encode(catalogId, forKey: "catalogId")
        aCoder.encode(teacher, forKey: "teacher")
        aCoder.encode(video, forKey: "video")
    }
}
