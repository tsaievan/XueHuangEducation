//
//  XHNetCourse.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHNetCourse: NSObject, Mappable {
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
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        catalogId         <- map["catalogId"]
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
}
