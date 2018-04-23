//
//  XHAccountLoginResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 22/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHAccountLoginResult: NSObject, Mappable,NSCoding {
    ///< Url
    var Url: String?
    ///< 状态信息 `ok`等
    var msg: String?
    ///< 状态
    var states: Bool?
    ///< 结果封装
    var result: XHLoginBaseResult?
    ///< member封装
    var member: XHLoginMember?
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
        Url              <- map["Url"]
        msg              <- map["msg"]
        states           <- map["states"]
        result           <- map["result"]
        member           <- map["member"]
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
    
    required init?(coder aDecoder: NSCoder) {
        Url = aDecoder.decodeObject(forKey: "Url") as? String
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        states = aDecoder.decodeObject(forKey: "states") as? Bool
        result = aDecoder.decodeObject(forKey: "result") as? XHLoginBaseResult
        member = aDecoder.decodeObject(forKey: "member") as? XHLoginMember
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
        aCoder.encode(Url, forKey: "Url")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(states, forKey: "states")
        aCoder.encode(result, forKey: "result")
        aCoder.encode(member, forKey: "member")
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
}
