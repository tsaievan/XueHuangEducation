//
//  XHAccountLoginResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 22/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHAccountLoginResult: NSObject, Mappable {
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
}
