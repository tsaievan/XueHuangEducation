//
//  UIResponder+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 26/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIResponder {
    @objc ///< 由于swift4.0不支持override extension中的function, 所以必须加上@objc
    func router(withEventName eventName: String, userInfo: [String : Any]) {
        next?.router(withEventName: eventName, userInfo: userInfo)
    }
}
