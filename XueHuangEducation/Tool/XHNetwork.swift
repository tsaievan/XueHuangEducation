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
typealias FailueBlock = (NSError) -> ()

public struct XHNetworkError {
    
    ///< 错误代码
    struct Code {
        static let noData: Int = -1
        static let connetFailue: Int = NSURLErrorNotConnectedToInternet
    }
    
    ///< 错误描述
    struct Desription {
        struct TeachViewController {}
        struct ThemeViewController {}
        static let connectFailue: String = "网络连接失败, 请检查网络"
        static let commonError: String = "数据加载失败"
    }
}

class XHNetwork {
    
    static fileprivate var sessionManager: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10 ///< 设置超时时长为10秒
        return Alamofire.SessionManager(configuration: config)
    }()
    
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
                cookieDict[cookie.name] = cookie.value
            }
            var cookieString = ""
            for (k, v) in cookieDict {
                let string = String(format: "%@=%@;", k, v)
                cookieString = cookieString.appending(string)
            }
            cookieHeader["Cookie"] = cookieString
        }
        sessionManager.request((XHURL.base as NSString).appendingPathComponent(url), method: .get, parameters: params, encoding: URLEncoding.default, headers: cookieHeader).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                let err = error as NSError
                ///< 当错误码为-999时, 表示请求取消, 这时候拦截, 直接return
                ///< 不然会弹出提示框, 影响用户体验
                if err.code == NSURLErrorCancelled {
                    return
                }
                failue?(err)
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
        sessionManager.request((XHURL.base as NSString).appendingPathComponent(url), method: .get, parameters: params, encoding: URLEncoding.default, headers: cookieHeader).responseString { (response) in
            switch response.result {
            case .success(let value):
                success?(value)
            case .failure(let error):
                let err = error as NSError
                ///< 当错误码为-999时, 表示请求取消, 这时候拦截, 直接return
                ///< 不然会弹出提示框, 影响用户体验
                if err.code == NSURLErrorCancelled {
                    return
                }
                failue?(err)
            }
        }
    }
    
    /// 返回一个特定的网页url
    ///
    /// - Parameters:
    ///   - url: 需要拼接的urlString
    ///   - params: 需要拼接的参数
    /// - Returns: 返回一个特定的网页url
    class func getWebUrl(withUrl url: String, params: [String : Any]) -> URL? {
        let baseUrl = XHURL.base
        var urlString = (baseUrl as NSString).appending(url)
        for (k, v) in params {
            let string = "&" + "\(k)=\(v)"
            urlString = urlString.appending(string)
        }
        guard let newStr = (urlString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue) else {
            return nil
        }
        return URL(string: newStr)
    }
    
    ///< 取消所有请求
    class func cancelAllRequest() {
        sessionManager.session.getAllTasks { (tasks) in
            tasks.forEach({ (task) in
                task.cancel()
            })
        }
    }
}

