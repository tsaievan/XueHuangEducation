//
//  UIDevice+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIDevice {
    ///< 判断是否是 iPhoneX
    class var iPhoneX: Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
    
    class var iPhoneSE: Bool {
        if UIScreen.main.bounds.height == 568 {
            return true
        }
        return false
    }
}
