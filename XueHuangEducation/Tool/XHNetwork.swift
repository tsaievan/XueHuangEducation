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
    
    /// get请求, 得到的response是json字符串
    ///
    /// - Parameters:
    ///   - url: 请求的url地址
    ///   - params: 请求的参数
    ///   - success: 请求成功的回调
    ///   - failue: 请求失败的回调
    class func GET(url: String, params: [String : Any]?, success: SuccessBlock?, failue: FailueBlock?) {
        ///< 发送请求的时候要把cookie的值拼接到header发送给服务器
        var cookieDict = [String : String]()
        let cookieJar =  HTTPCookieStorage.shared
        var cookieHeader = HTTPHeaders()
        if let cookies = cookieJar.cookies {
            for cookie in cookies {
                if cookie.domain != "120.77.242.84" {
                    continue
                }
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
    
    /// get请求, 得到的response是非json字符串
    ///
    /// - Parameters:
    ///   - url: 请求的url地址
    ///   - params: 请求参数
    ///   - success: 请求成功的回调
    ///   - failue: 请求失败的回调
    class func GET_ResponseString(url: String, params: [String : Any]?, success: SuccessBlock?, failue: FailueBlock?) {
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
        Alamofire.request((URL_BASE as NSString).appendingPathComponent(url), method: .get, parameters: params, encoding: URLEncoding.default, headers: cookieHeader).responseString { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                failue?(error)
            }
        }
    }
    
    class func getWebUrl(withUrl url: String, params: [String : Any]) -> URL? {
        let baseUrl = URL_BASE
        var urlString = (baseUrl as NSString).appending(url)
        for (k, v) in params {
            let string = "&" + "\(k)=\(v)"
            urlString = urlString.appending(string)
        }
        return URL(string: urlString)
    }
}

