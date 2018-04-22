//
//  String+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension String {
    subscript (r: Range<Int>) -> String{
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
}
