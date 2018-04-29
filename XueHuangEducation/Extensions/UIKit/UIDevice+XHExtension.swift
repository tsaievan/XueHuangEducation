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
    
    class var iPhone8: Bool {
        if UIScreen.main.bounds.height == 667 {
            return true
        }
        return false
    }
    
    class var iPhone8Plus: Bool {
        if UIScreen.main.bounds.height == 736 {
            return true
        }
        return false
    }
    
    class var horizontalScale: CGFloat {
        if iPhoneSE {
            return 1.0
        }else if iPhone8 {
            return 375 / 320
        }else if iPhone8Plus {
            return 414 / 320
        }else if iPhoneX {
            return 375 / 320
        }else {
            return 1.0
        }
    }
}
