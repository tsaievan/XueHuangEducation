//
//  XHCourseCatalog.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHCourseCatalog: NSObject, Mappable {
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
    }
}
