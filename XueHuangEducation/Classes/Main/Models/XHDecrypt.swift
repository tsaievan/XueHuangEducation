//
//  XHDecrypt.swift
//  XueHuangEducation
//
//  Created by tsaievan on 28/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHGetDecryptedPlayerUrlSuccess = (String) -> ()
typealias XHGetDecryptedPlayerUrlFailue = (String) -> ()

enum XHDecryptedType {
    case play
    case download
}

///< 解密播放/下载视频链接
class XHDecrypt {

    class func getDecryptedPlayerUrl(withOriginalUrl originalUrl: String, decryptedType: XHDecryptedType, success: XHGetDecryptedPlayerUrlSuccess?, failue: XHGetDecryptedPlayerUrlFailue?) {
        let params = [
            "encryptMp4Url" : originalUrl
        ]
        var url = ""
        if decryptedType == .play {
            url = XHURL.AppController.getDecryptPlayMp4Url
        }else {
            url = XHURL.AppController.getDecryptDownloadMp4Url
        }
        XHNetwork.GET_ResponseString(url: url, params: params, success: { (response) in
            guard let videoUrl = response as? String else {
                    return
            }
            success?(videoUrl)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?("获取加密视频链接失败")
            }
        }
    }
    
    class func getDecryptDownloadMp4Url(withOriginalUrl originalUrl: String, success: XHGetDecryptedPlayerUrlSuccess?, failue: XHGetDecryptedPlayerUrlFailue?) {
        let params = [
            "encryptMp4Url" : originalUrl
        ]
        let url = XHURL.AppController.getDecryptDownloadMp4Url
        XHNetwork.GET(url: url, params: params, success: { (response) in
            guard let videoUrl = response as? String else {
                return
            }
            success?(videoUrl)
        }) { (error) in
            if error.code == XHNetworkError.Code.connetFailue {
                failue?(XHNetworkError.Desription.connectFailue)
            }else {
                failue?("获取加密视频链接失败")
            }
        }
    }
}
