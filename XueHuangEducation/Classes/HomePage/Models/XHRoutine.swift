//
//  XHRoutine.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHRoutine: NSObject, Mappable, NSCoding {
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
    ///< 更新者
    var updateBy: String?
    ///< 更新日期
    var updateDate: XHCreatTime?
    ///< 更新者姓名
    var updateName: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {

        createDate        <- map["createDate"]
        createName        <- map["createName"]
        delDate           <- map["delDate"]
        delflag           <- map["delflag"]
        id                <- map["id"]
        updateBy          <- map["updateBy"]
        updateDate        <- map["updateDate"]
        updateName        <- map["updateName"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        createDate = aDecoder.decodeObject(forKey: "createDate") as? XHCreatTime
        createName = aDecoder.decodeObject(forKey: "createName") as? String
        delDate = aDecoder.decodeObject(forKey: "delDate") as? Int
        delflag = aDecoder.decodeObject(forKey: "delflag") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? String
        updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
        updateDate = aDecoder.decodeObject(forKey: "updateDate") as? XHCreatTime
        updateName = aDecoder.decodeObject(forKey: "updateName") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(createDate, forKey: "createDate")
        aCoder.encode(createName, forKey: "createName")
        aCoder.encode(delDate, forKey: "delDate")
        aCoder.encode(delflag, forKey: "delflag")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(updateBy, forKey: "updateBy")
        aCoder.encode(updateDate, forKey: "updateDate")
        aCoder.encode(updateName, forKey: "updateName")
    }
}
