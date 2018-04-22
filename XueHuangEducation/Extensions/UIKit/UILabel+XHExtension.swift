//
//  UILabel+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 17/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String?, textColor: UIColor?, fontSize: CGFloat = 14) {
        self.init()
        font = UIFont.systemFont(ofSize: fontSize)
        self.text = text
        self.textColor = textColor
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
    }
}
