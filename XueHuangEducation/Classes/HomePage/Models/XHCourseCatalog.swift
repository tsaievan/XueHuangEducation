//
//  XHCourseCatalog.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

enum XHCourseCatalogCodingKeys: CodingKey {
    case courseClassCode
    case courseClassLevel
    case courseClassName
    case courseClassOrder
    case createBy
    case createDate
    case createName
    case delDate
    case delflag
    case iconAddr
    case id
    case pId
    case updateBy
    case updateDate
    case updateName
    case customName
}

class XHCourseCatalog: XHBaseModel {
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
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
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
        super.init(coder: aDecoder)
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
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
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
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let vaules = try? decoder.container(keyedBy: XHCourseCatalogCodingKeys.self)
        courseClassCode = try vaules?.decode(String.self, forKey: .courseClassCode)
        courseClassLevel = try vaules?.decode(String.self, forKey: .courseClassLevel)
        courseClassName = try vaules?.decode(String.self, forKey: .courseClassName)
        courseClassOrder = try vaules?.decode(String.self, forKey: .courseClassOrder)
        createBy = try vaules?.decode(String.self, forKey: .createBy)
        createDate = try vaules?.decode(XHCreatTime.self, forKey: .createDate)
        createName = try vaules?.decode(String.self, forKey: .createName)
        delDate = try vaules?.decode(Int.self, forKey: .delDate)
        delflag = try vaules?.decode(Int.self, forKey: .delflag)
        iconAddr = try vaules?.decode(String.self, forKey: .iconAddr)
        id = try vaules?.decode(String.self, forKey: .id)
        pId = try vaules?.decode(String.self, forKey: .pId)
        updateBy = try vaules?.decode(String.self, forKey: .updateBy)
        updateDate = try vaules?.decode(XHCreatTime.self, forKey: .updateDate)
        updateName = try vaules?.decode(String.self, forKey: .updateName)
        customName = try vaules?.decode(String.self, forKey: .customName)
    }
    
    override func encode(to encoder: Encoder) throws {
        try? super.encode(to: encoder)
        var courseCatalog = encoder.container(keyedBy: XHCourseCatalogCodingKeys.self)
        try courseCatalog.encode(courseClassCode, forKey: .courseClassCode)
        try courseCatalog.encode(courseClassLevel, forKey: .courseClassLevel)
        try courseCatalog.encode(courseClassName, forKey: .courseClassName)
        try courseCatalog.encode(courseClassOrder, forKey: .courseClassOrder)
        try courseCatalog.encode(createBy, forKey: .createBy)
        try courseCatalog.encode(createDate, forKey: .createDate)
        try courseCatalog.encode(createName, forKey: .createName)
        try courseCatalog.encode(delDate, forKey: .delDate)
        try courseCatalog.encode(delflag, forKey: .delflag)
        try courseCatalog.encode(iconAddr, forKey: .iconAddr)
        try courseCatalog.encode(id, forKey: .id)
        try courseCatalog.encode(pId, forKey: .pId)
        try courseCatalog.encode(updateBy, forKey: .updateBy)
        try courseCatalog.encode(updateDate, forKey: .updateDate)
        try courseCatalog.encode(updateName, forKey: .updateName)
        try courseCatalog.encode(customName, forKey: .customName)
    }
}
