//
//  XHProfileInfoModel.swift
//  XueHuangEducation
//
//  Created by tsaievan on 12/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

enum XHProfileCellAccessoryType {
    case arrow
    case xhSwitch
}

class XHProfileInfoModel: Mappable {
    
    var title: String?
    var accessory: XHProfileCellAccessoryType?
    var switchIsOn: Bool?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title      <- map["title"]
        accessory  <- map["accessory"]
        switchIsOn <- map["switchIsOn"]
    }
}
