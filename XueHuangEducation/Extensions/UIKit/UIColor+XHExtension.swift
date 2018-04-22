//
//  UIColor+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexColor: String) {
        ///< 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        var prefixCount = 0
        ///< 计算前缀数量
        if hexColor.hasPrefix("0x") || hexColor.hasPrefix("0X") { ///< 前缀有两位
            prefixCount = 2
        }
        if hexColor.hasPrefix("#") { ///< 前缀有一位
            prefixCount = 1
        }
        ///< 分别转换进行转换
        Scanner(string: hexColor[(0 + prefixCount)..<(2 + prefixCount)]).scanHexInt32(&red)
        Scanner(string: hexColor[(2 + prefixCount)..<(4 + prefixCount)]).scanHexInt32(&green)
        Scanner(string: hexColor[(4 + prefixCount)..<(6 + prefixCount)]).scanHexInt32(&blue)
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    convenience init(RGBHex hex: UInt32) {
        let r = CGFloat((hex >> 16) & 0xFF)
        let g = CGFloat((hex >> 8) & 0xFF)
        let b = CGFloat((hex) & 0xFF)
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}

