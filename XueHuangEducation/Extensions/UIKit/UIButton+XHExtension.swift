//
//  UIButton+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 17/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     titleColor: UIColor? = UIColor.Global.darkGray,
                     selectedColor: UIColor? = UIColor.Global.darkGray,
                     fontSize: CGFloat? = 14,
                     target: Any?,
                     action: Selector,
                     controlEvents: UIControlEvents = .touchUpInside) {
        self.init(type: .custom)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(selectedColor, for: .selected)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        addTarget(target, action: action, for: controlEvents)
        sizeToFit()
    }
}
