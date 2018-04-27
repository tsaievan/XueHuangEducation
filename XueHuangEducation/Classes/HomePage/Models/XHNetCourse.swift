//
//  XHNetCourse.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHNetCourse: NSObject, Mappable, NSCoding {
    ///< 分类id
    var catalogId: String?
    ///< 课程讲师
    var courseTeacher: String?
    ///< 创建者
    var creatBy: String?
    ///< 创建时间
    var createDate: XHCreatTime?
    ///< 创建姓名
    var createName: String?
    ///< 删除时间
    var delDate: Int?
    ///< 删除标记
    var delflag: Int?
    ///< id
    var id: String?
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
    ///< 更新者
    var updateBy: String?
    ///< 更新日期
    var updateDate: XHCreatTime?
    ///< 更新者姓名
    var updateName: String?
    ///< 视频地址
    var video: String?
    ///< 视频文件地址
    var videoSrc: String?
    ///< 分类名称
    var catalogName: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        catalogId         <- map["catalogId"]
        catalogName       <- map["catalogName"]
        courseTeacher     <- map["courseTeacher"]
        creatBy           <- map["creatBy"]
        createDate        <- map["createDate"]
        createName        <- map["createName"]
        delDate           <- map["delDate"]
        delflag           <- map["delflag"]
        id                <- map["id"]
        isrecom           <- map["isrecom"]
        netCourseId       <- map["netCourseId"]
        netCourseName     <- map["netCourseName"]
        netCourseOrder    <- map["netCourseOrder"]
        st                <- map["st"]
        state             <- map["state"]
        updateBy          <- map["updateBy"]
        updateDate        <- map["updateDate"]
        updateName        <- map["updateName"]
        video             <- map["video"]
        videoSrc          <- map["videoSrc"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        catalogId = aDecoder.decodeObject(forKey: "catalogId") as? String
        catalogName = aDecoder.decodeObject(forKey: "catalogName") as? String
        courseTeacher = aDecoder.decodeObject(forKey: "courseTeacher") as? String
        creatBy = aDecoder.decodeObject(forKey: "creatBy") as? String
        createDate = aDecoder.decodeObject(forKey: "createDate") as? XHCreatTime
        createName = aDecoder.decodeObject(forKey: "createName") as? String
        delDate = aDecoder.decodeObject(forKey: "delDate") as? Int
        delflag = aDecoder.decodeObject(forKey: "delflag") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? String
        isrecom = aDecoder.decodeObject(forKey: "isrecom") as? Bool
        netCourseId = aDecoder.decodeObject(forKey: "netCourseId") as? String
        netCourseName = aDecoder.decodeObject(forKey: "netCourseName") as? String
        netCourseOrder = aDecoder.decodeObject(forKey: "netCourseOrder") as? Int
        st = aDecoder.decodeObject(forKey: "st") as? Int
        state = aDecoder.decodeObject(forKey: "state") as? Int
        updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
        updateDate = aDecoder.decodeObject(forKey: "updateDate") as? XHCreatTime
        updateName = aDecoder.decodeObject(forKey: "updateName") as? String
        video = aDecoder.decodeObject(forKey: "video") as? String
        videoSrc = aDecoder.decodeObject(forKey: "videoSrc") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(catalogId, forKey: "catalogId")
        aCoder.encode(catalogName, forKey: "catalogName")
        aCoder.encode(courseTeacher, forKey: "courseTeacher")
        aCoder.encode(creatBy, forKey: "creatBy")
        aCoder.encode(createDate, forKey: "createDate")
        aCoder.encode(createName, forKey: "createName")
        aCoder.encode(delDate, forKey: "delDate")
        aCoder.encode(delflag, forKey: "delflag")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(isrecom, forKey: "isrecom")
        aCoder.encode(netCourseId, forKey: "netCourseId")
        aCoder.encode(netCourseName, forKey: "netCourseName")
        aCoder.encode(netCourseOrder, forKey: "netCourseOrder")
        aCoder.encode(st, forKey: "st")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(updateBy, forKey: "updateBy")
        aCoder.encode(updateDate, forKey: "updateDate")
        aCoder.encode(updateName, forKey: "updateName")
        aCoder.encode(video, forKey: "video")
        aCoder.encode(videoSrc, forKey: "videoSrc")
    }
}
