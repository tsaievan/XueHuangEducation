//
//  XHCourseCatalog.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHCourseCatalog: XHRoutine {
    ///< courseClassCode
    var courseClassCode: String?
    ///< 课程分类级别
    var courseClassLevel: String?
    ///< 课程分类名称
    var courseClassName: String?
    ///< 课程分类顺序
    var courseClassOrder: String?
    ///< 创建者
    var createBy: String?
    ///< icon图片地址
    var iconAddr: String?
    ///< pId
    var pId: String?
    ///< 自定义名称
    var customName: String?
    ///< 分组是否展开
    var isFold: Bool? = true
    ///< 轮播图的url. 其实轮播图只有一张
    var imgAddr: String?
    ///< 课程数组
    var simpleNetCourses: [XHSimpleNetCourse]?
    ///< 考卷数组
    var paperLists: [XHPaper]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        courseClassCode                 <- map["courseClassCode"]
        courseClassLevel                <- map["courseClassLevel"]
        courseClassName                 <- map["courseClassName"]
        courseClassOrder                <- map["courseClassOrder"]
        createBy                        <- map["createBy"]
        iconAddr                        <- map["iconAddr"]
        pId                             <- map["pId"]
        customName                      <- map["customName"]
        simpleNetCourses                <- map["simpleNetCourses"]
        isFold                          <- map["isFold"]
        imgAddr                         <- map["imgAddr"]
        paperLists                      <- map["paperLists"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        courseClassCode = aDecoder.decodeObject(forKey: "courseClassCode") as? String
        courseClassLevel = aDecoder.decodeObject(forKey: "courseClassLevel") as? String
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        courseClassOrder = aDecoder.decodeObject(forKey: "courseClassOrder") as? String
        createBy = aDecoder.decodeObject(forKey: "createBy") as? String
        iconAddr = aDecoder.decodeObject(forKey: "iconAddr") as? String
        pId = aDecoder.decodeObject(forKey: "pId") as? String
        customName = aDecoder.decodeObject(forKey: "customName") as? String
        simpleNetCourses = aDecoder.decodeObject(forKey: "simpleNetCourses") as? [XHSimpleNetCourse]
        isFold = aDecoder.decodeObject(forKey: "isFold") as? Bool
        imgAddr = aDecoder.decodeObject(forKey: "imgAddr") as? String
        paperLists = aDecoder.decodeObject(forKey: "paperLists") as? [XHPaper]
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(courseClassCode, forKey: "courseClassCode")
        aCoder.encode(courseClassLevel, forKey: "courseClassLevel")
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(courseClassOrder, forKey: "courseClassOrder")
        aCoder.encode(createBy, forKey: "createBy")
        aCoder.encode(iconAddr, forKey: "iconAddr")
        aCoder.encode(pId, forKey: "pId")
        aCoder.encode(customName, forKey: "customName")
        aCoder.encode(simpleNetCourses, forKey: "simpleNetCourses")
        aCoder.encode(isFold, forKey: "isFold")
        aCoder.encode(imgAddr, forKey: "imgAddr")
        aCoder.encode(paperLists, forKey: "paperLists")
    }
}
