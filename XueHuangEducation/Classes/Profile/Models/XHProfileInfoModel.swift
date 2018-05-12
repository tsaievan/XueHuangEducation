//
//  XHProfileInfoModel.swift
//  XueHuangEducation
//
//  Created by tsaievan on 12/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import ObjectMapper

class XHProfileInfoModel: Mappable {
    
    var title: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title     <- map["title"]
    }
    


}
