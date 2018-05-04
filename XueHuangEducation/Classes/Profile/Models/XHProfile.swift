//
//  XHProfile.swift
//  XueHuangEducation
//
//  Created by tsaievan on 4/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHProfile {
    
    class func getMobile() {
        XHNetwork.GET(url: URL_TO_MOBILE_PERSON, params: nil, success: { (response) in
            print("\(response)")
        }) { (error) in
            print("\(error)")
        }
    }
}
