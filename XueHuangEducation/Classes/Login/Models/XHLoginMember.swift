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
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accounts, forKey: "accounts")
        aCoder.encode(area, forKey: "area")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(company, forKey: "company")
        aCoder.encode(createDate, forKey: "createDate")
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
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        accounts     <- map["accounts"]
        area         <- map["area"]
        city         <- map["city"]
        company      <- map["company"]
        createDate   <- map["createDate"]
        
    }
}
