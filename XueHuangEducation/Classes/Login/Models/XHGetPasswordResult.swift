//
//  XHGetPasswordResult.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHGetPasswordResult: NSObject, Mappable, NSCoding {
    ///< 结果
    ///< 有该用户并成功获取验证码: ok
    ///< 有该用户但获取验证码失败: no
    ///< 没有该用户: nophone
    var result: String?
    
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
    }
    
    func mapping(map: Map) {
        result        <- map["result"]
        username      <- map["username"]
        userid        <- map["userid"]
        code          <- map["code"]
        msg           <- map["msg"]
        currentTime   <- map["currentTime"]
    }
    
    ///< 实现归结档的协议方法
    required init?(coder aDecoder: NSCoder) {
        result = aDecoder.decodeObject(forKey: "result") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        userid = aDecoder.decodeObject(forKey: "userid") as? String
        code = aDecoder.decodeObject(forKey: "code") as? String
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        currentTime = aDecoder.decodeObject(forKey: "currentTime") as? Double
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(result, forKey: "result")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(userid, forKey: "userid")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(msg, forKey: "msg")
        aCoder.encode(currentTime, forKey: "currentTime")
    }
}



