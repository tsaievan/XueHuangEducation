//
//  XHNetCourse.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHNetCourse: XHRoutine {
    ///< 分类id
    var catalogId: String?
    ///< 课程讲师
    var courseTeacher: String?
    ///< 创建者
    var creatBy: String?
    ///< 是否推荐
    var isrecom: Bool?
    ///< 课程id
    var netCourseId: String?
    ///< 课程名称
    var netCourseName: String?
    ///< 课程顺序
    var netCourseOrder: Int?
    ///< st
    var st: Int?
    ///< 状态
    var state: Int?
    ///< 视频地址
    var video: String?
    ///< 视频文件地址
    var videoSrc: String?
    ///< 分类名称
    var catalogName: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        catalogId         <- map["catalogId"]
        catalogName       <- map["catalogName"]
        courseTeacher     <- map["courseTeacher"]
        creatBy           <- map["creatBy"]
        isrecom           <- map["isrecom"]
        netCourseId       <- map["netCourseId"]
        netCourseName     <- map["netCourseName"]
        netCourseOrder    <- map["netCourseOrder"]
        st                <- map["st"]
        state             <- map["state"]
        video             <- map["video"]
        videoSrc          <- map["videoSrc"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        catalogId = aDecoder.decodeObject(forKey: "catalogId") as? String
        catalogName = aDecoder.decodeObject(forKey: "catalogName") as? String
        courseTeacher = aDecoder.decodeObject(forKey: "courseTeacher") as? String
        creatBy = aDecoder.decodeObject(forKey: "creatBy") as? String
        isrecom = aDecoder.decodeObject(forKey: "isrecom") as? Bool
        netCourseId = aDecoder.decodeObject(forKey: "netCourseId") as? String
        netCourseName = aDecoder.decodeObject(forKey: "netCourseName") as? String
        netCourseOrder = aDecoder.decodeObject(forKey: "netCourseOrder") as? Int
        st = aDecoder.decodeObject(forKey: "st") as? Int
        state = aDecoder.decodeObject(forKey: "state") as? Int
        video = aDecoder.decodeObject(forKey: "video") as? String
        videoSrc = aDecoder.decodeObject(forKey: "videoSrc") as? String
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(catalogId, forKey: "catalogId")
        aCoder.encode(catalogName, forKey: "catalogName")
        aCoder.encode(courseTeacher, forKey: "courseTeacher")
        aCoder.encode(creatBy, forKey: "creatBy")
        aCoder.encode(isrecom, forKey: "isrecom")
        aCoder.encode(netCourseId, forKey: "netCourseId")
        aCoder.encode(netCourseName, forKey: "netCourseName")
        aCoder.encode(netCourseOrder, forKey: "netCourseOrder")
        aCoder.encode(st, forKey: "st")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(video, forKey: "video")
        aCoder.encode(videoSrc, forKey: "videoSrc")
    }
}
