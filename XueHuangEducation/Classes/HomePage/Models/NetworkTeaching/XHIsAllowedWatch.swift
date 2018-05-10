//
//  XHIsAllowedWatch.swift
//  XueHuangEducation
//
//  Created by tsaievan on 8/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHIsAllowedWatch: XHIsAllowedCommon {
    ///< 视频的排序编号
    var st: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        st <- map["st"]
    }
}
