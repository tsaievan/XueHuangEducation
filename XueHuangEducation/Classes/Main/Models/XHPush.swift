//
//  XHPush.swift
//  XueHuangEducation
//
//  Created by tsaievan on 21/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetPushedNotificationSuccess = (XHPushNotificationModel) -> ()
typealias XHGetPushedNotificationFailue = (String) -> ()

class XHPush {
    
    /// 获取推送消息的接口
    ///
    /// - Parameters:
    ///   - success: 请求接口成功的回调
    ///   - failue: 请求接口失败的回调
    class func getPushedNotification(success: XHGetPushedNotificationSuccess?, failue: XHGetPushedNotificationFailue?) {
        XHNetwork.GET(url: XHURL.AppController.push, params: nil, success: { (response) in
            guard let responseJson = response as? [String : Any],
            let model = XHPushNotificationModel(JSON: responseJson) else {
                return
            }
            success?(model)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?("获取推送消息失败")
            }
        }
    }
}
