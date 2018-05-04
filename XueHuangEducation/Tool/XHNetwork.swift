//
//  XHNetwork.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import Alamofire

typealias SuccessBlock = (Any) -> ()
typealias FailueBlock = (Error) -> ()


class XHNetwork {
    class func GET(url: String, params: [String : Any]?, success: SuccessBlock?, failue: FailueBlock?) {
        ///< 发送请求的时候要把cookie的值拼接到header发送给服务器
        var cookieDict = [String : String]()
        let cookieJar =  HTTPCookieStorage.shared
        var cookieHeader = HTTPHeaders()
        if let cookies = cookieJar.cookies {
            for cookie in cookies {
                cookieDict[cookie.name] = cookie.value
            }
            var cookieString = ""
            for (k, v) in cookieDict {
                let string = String(format: "%@=%@;", k, v)
                cookieString = cookieString.appending(string)
            }
            cookieHeader["Cookie"] = cookieString
        }
        Alamofire.request((URL_BASE as NSString).appendingPathComponent(url), method: .get, parameters: params, encoding: URLEncoding.default, headers: cookieHeader).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                failue?(error)
            }
        }
    }
    
    class func GET_ResponseString(url: String, params: [String : Any]?, success: SuccessBlock?, failue: FailueBlock?) {
        Alamofire.request((URL_BASE as NSString).appendingPathComponent(url), method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                failue?(error)
            }
        }
    }
}

