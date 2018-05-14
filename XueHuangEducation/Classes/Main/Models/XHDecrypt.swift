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
        var params = [String : Any]()
        
        
        params = [
            "encryptMp4Url" : originalUrl
        ]
        XHNetwork.GET_ResponseString(url: URL_APP_DECRYPT_VIDEO_PLAYER_URL, params: params, success: { (response) in
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
    
    class func getDecryptedDownloadUrl(withOriginalUrl originalUrl: String, success: XHGetDecryptedDownloadUrlSuccess?, failue: XHGetDecryptedDownloadUrlFailue?) {
        let params = [
            "encryptMp4Url" : originalUrl
        ]
        XHNetwork.GET(url: XHURL.AppController.getDecryptDownloadMp4Url, params: params, success: { (response) in
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
