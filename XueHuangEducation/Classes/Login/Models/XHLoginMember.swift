//
//  XHLoginMember.swift
//  XueHuangEducation
//
//  Created by tsaievan on 22/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHCreatTime: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(day, forKey: "day")
        aCoder.encode(hours, forKey: "hours")
        aCoder.encode(minutes, forKey: "minutes")
        aCoder.encode(month, forKey: "month")
        aCoder.encode(seconds, forKey: "seconds")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(timezoneOffset, forKey: "timezoneOffset")
        aCoder.encode(year, forKey: "year")
    }
    
    required init?(coder aDecoder: NSCoder) {
        date = aDecoder.decodeObject(forKey: "date") as? Int16
        day = aDecoder.decodeObject(forKey: "day") as? Int16
        hours = aDecoder.decodeObject(forKey: "hours") as? Int16
        minutes = aDecoder.decodeObject(forKey: "minutes") as? Int16
        month = aDecoder.decodeObject(forKey: "month") as? Int16
        seconds = aDecoder.decodeObject(forKey: "seconds") as? Int16
        time = aDecoder.decodeObject(forKey: "time") as? TimeInterval
        timezoneOffset = aDecoder.decodeObject(forKey: "timezoneOffset") as? Int
        year = aDecoder.decodeObject(forKey: "year") as? Int
    }
    
    var date: Int16?
    var day: Int16?
    var hours: Int16?
    var minutes: Int16?
    var month: Int16?
    var seconds: Int16?
    var time: TimeInterval?
    var timezoneOffset: Int?
    var year: Int?
}

class XHLoginMember: NSObject, Mappable, NSCoding {
    required init?(coder aDecoder: NSCoder) {
        accounts = aDecoder.decodeObject(forKey: "accounts") as? String
        area = aDecoder.decodeObject(forKey: "area") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        company = aDecoder.decodeObject(forKey: "company") as? String
        createDate = aDecoder.decodeObject(forKey: "createDate") as? XHCreatTime
        emailbind = aDecoder.decodeObject(forKey: "emailbind") as? String
        endTime = aDecoder.decodeObject(forKey: "endTime") as? TimeInterval
        id = aDecoder.decodeObject(forKey: "id") as? String
        isDownloadVideo = aDecoder.decodeObject(forKey: "isDownloadVideo") as? Int
        loginPassword = aDecoder.decodeObject(forKey: "loginPassword") as? String
        phonebind = aDecoder.decodeObject(forKey: "phonebind") as? String
        photo = aDecoder.decodeObject(forKey: "photo") as? String
        position = aDecoder.decodeObject(forKey: "position") as? String
        province = aDecoder.decodeObject(forKey: "province") as? String
        regLocation = aDecoder.decodeObject(forKey: "regLocation") as? Int
        startTime = aDecoder.decodeObject(forKey: "startTime") as? TimeInterval
        state = aDecoder.decodeObject(forKey: "state") as? Int
        updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
        updateDate = aDecoder.decodeObject(forKey: "updateDate") as? TimeInterval
        updateName = aDecoder.decodeObject(forKey: "updateName") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accounts, forKey: "accounts")
        aCoder.encode(area, forKey: "area")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(company, forKey: "company")
        aCoder.encode(createDate, forKey: "createDate")
        aCoder.encode(emailbind, forKey: "emailbind")
        aCoder.encode(endTime, forKey: "endTime")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(isDownloadVideo, forKey: "isDownloadVideo")
        aCoder.encode(loginPassword, forKey: "loginPassword")
        aCoder.encode(phonebind, forKey: "phonebind")
        aCoder.encode(photo, forKey: "photo")
        aCoder.encode(position, forKey: "position")
        aCoder.encode(province, forKey: "province")
        aCoder.encode(regLocation, forKey: "regLocation")
        aCoder.encode(startTime, forKey: "startTime")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(updateBy, forKey: "updateBy")
        aCoder.encode(updateDate, forKey: "updateDate")
        aCoder.encode(updateName, forKey: "updateName")
    }
    
    ///< 账户名
    var accounts: String?
    ///< 地区
    var area: String?
    ///< 城市
    var city: String?
    ///< 公司
    var company: String?
    ///< 创建时间
    var createDate: XHCreatTime?
    ///< 绑定邮箱
    var emailbind: String?
    ///< 终止时间
    var endTime: TimeInterval?
    ///< id
    var id: String?
    ///< 是否下载视频
    var isDownloadVideo: Int?
    ///< 登录密码
    var loginPassword: String?
    ///< 绑定手机
    var phonebind: String?
    ///< 图片
    var photo: String?
    ///< 位置
    var position: String?
    ///< 省份
    var province: String?
    ///< regLocation
    var regLocation: Int?
    ///< 开始时间
    var startTime: TimeInterval?
    ///< 状态
    var state: Int?
    ///< 更新者
    var updateBy: String?
    ///< 更新日期
    var updateDate: TimeInterval?
    ///< 更新名称
    var updateName: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        accounts     <- map["accounts"]
        area         <- map["area"]
        city         <- map["city"]
        company      <- map["company"]
        createDate   <- map["createDate"]
        emailbind        <- map["emailbind"]
        endTime          <- map["endTime"]
        id               <- map["id"]
        isDownloadVideo  <- map["isDownloadVideo"]
        loginPassword    <- map["loginPassword"]
        phonebind        <- map["phonebind"]
        photo            <- map["photo"]
        position         <- map["position"]
        province         <- map["province"]
        regLocation      <- map["regLocation"]
        startTime        <- map["startTime"]
        state            <- map["state"]
        updateBy         <- map["updateBy"]
        updateDate       <- map["updateDate"]
        updateName       <- map["updateName"]
    }
}
