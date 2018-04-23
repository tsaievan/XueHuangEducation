//
//  XHGetPasswordResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHGetPasswordResult: XHResult {
    
    ///< 用户名
    var username: String?
    
    ///< 用户id
    var userid: String?
    
    ///< 验证码
    var code: String?
    
    ///< 有该用户但获取验证码失败消息
    var msg: String?
    
    ///< 时间戳
    var currentTime: Double?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        username      <- map["username"]
        userid        <- map["userid"]
        code          <- map["code"]
        msg           <- map["msg"]
        currentTime   <- map["currentTime"]
    }
    
    ///< 实现归结档的协议方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        username = aDecoder.decodeObject(forKey: "username") as? String
        userid = aDecoder.decodeObject(forKey: "userid") as? String
        code = aDecoder.decodeObject(forKey: "code") as? String
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        currentTime = aDecoder.decodeObject(forKey: "currentTime") as? Double
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(username, forKey: "username")
        aCoder.encode(userid, forKey: "userid")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(currentTime, forKey: "currentTime")
    }
}



