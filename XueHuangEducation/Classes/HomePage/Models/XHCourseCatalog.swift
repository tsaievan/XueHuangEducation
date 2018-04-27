//
//  XHCourseCatalog.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHCourseCatalog: NSObject, Mappable, NSCoding {
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
    ///< 穿件时间
    var createDate: XHCreatTime?
    ///< 创建者姓名
    var createName: String?
    ///< 删除时间
    var delDate: Int?
    ///< 删除标记
    var delflag: Int?
    ///< icon图片地址
    var iconAddr: String?
    ///< id
    var id: String?
    ///< pId
    var pId: String?
    ///< 更新者
    var updateBy: String?
    ///< 更新日期
    var updateDate: XHCreatTime?
    ///< 更新者姓名
    var updateName: String?
    ///< 自定义名称
    var customName: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        courseClassCode           <- map["courseClassCode"]
        courseClassLevel          <- map["courseClassLevel"]
        courseClassName           <- map["courseClassName"]
        courseClassOrder          <- map["courseClassOrder"]
        createBy                  <- map["createBy"]
        createDate                <- map["createDate"]
        createName                <- map["createName"]
        delDate                   <- map["delDate"]
        delflag                   <- map["delflag"]
        iconAddr                  <- map["iconAddr"]
        id                        <- map["id"]
        pId                       <- map["pId"]
        updateBy                  <- map["updateBy"]
        updateDate                <- map["updateDate"]
        updateName                <- map["updateName"]
        customName                <- map["customName"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        courseClassCode = aDecoder.decodeObject(forKey: "courseClassCode") as? String
        courseClassLevel = aDecoder.decodeObject(forKey: "courseClassLevel") as? String
        courseClassName = aDecoder.decodeObject(forKey: "courseClassName") as? String
        courseClassOrder = aDecoder.decodeObject(forKey: "courseClassOrder") as? String
        createBy = aDecoder.decodeObject(forKey: "createBy") as? String
        createDate = aDecoder.decodeObject(forKey: "createDate") as? XHCreatTime
        createName = aDecoder.decodeObject(forKey: "createName") as? String
        delDate = aDecoder.decodeObject(forKey: "delDate") as? Int
        delflag = aDecoder.decodeObject(forKey: "delflag") as? Int
        iconAddr = aDecoder.decodeObject(forKey: "iconAddr") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        pId = aDecoder.decodeObject(forKey: "pId") as? String
        updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
        updateDate = aDecoder.decodeObject(forKey: "updateDate") as? XHCreatTime
        updateName = aDecoder.decodeObject(forKey: "updateName") as? String
        customName = aDecoder.decodeObject(forKey: "customName") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courseClassCode, forKey: "courseClassCode")
        aCoder.encode(courseClassLevel, forKey: "courseClassLevel")
        aCoder.encode(courseClassName, forKey: "courseClassName")
        aCoder.encode(courseClassOrder, forKey: "courseClassOrder")
        aCoder.encode(createBy, forKey: "createBy")
        aCoder.encode(createDate, forKey: "createDate")
        aCoder.encode(createName, forKey: "createName")
        aCoder.encode(delDate, forKey: "delDate")
        aCoder.encode(delflag, forKey: "delflag")
        aCoder.encode(iconAddr, forKey: "iconAddr")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(pId, forKey: "pId")
        aCoder.encode(updateBy, forKey: "updateBy")
        aCoder.encode(updateDate, forKey: "updateDate")
        aCoder.encode(updateName, forKey: "updateName")
        aCoder.encode(customName, forKey: "customName")
    }
}
