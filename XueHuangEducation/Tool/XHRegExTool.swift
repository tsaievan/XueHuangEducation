//
//  XHRegExTool.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHRegExTool {
    
    ///< 正则判断是否是手机号码
    class func isPhoneNumber(phoneNumber: String) -> Bool {
        let phone = phoneNumber as NSString
        if phone.length != 11 {
            return false
        }
        ///< 手机号码
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$"
        ///< 中国移动
        let CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
        ///< 中国联通
        let CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
        ///< 中国电信
        let CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
        
        let mobileRegEx = NSPredicate(format: "SELF MATCHES %@",mobile)
        let CMRegEx = NSPredicate(format: "SELF MATCHES %@", CM)
        let CURegEx = NSPredicate(format: "SELF MATCHES %@", CU)
        let CTRegEx = NSPredicate(format: "SELF MATCHES %@", CT)
        
        if mobileRegEx.evaluate(with: phone)
        || CMRegEx.evaluate(with: phone)
        || CURegEx.evaluate(with: phone)
        || CTRegEx.evaluate(with: phone) {
            return true
        }else {
            return false
        }
    }
}
