//
//  XHPushNotificationModel.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHPushNotificationModel: Mappable {
    ///< 推送的id
    var pushId: String?
    ///< 推送时间
    var time: String?
    ///< 标题
    var title: String?
    ///< 具体内容
    var details: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pushId       <- map["pushId"]
        time         <- map["time"]
        title        <- map["title"]
        details      <- map["details"]
    }
}
