//
//  UIView+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 16/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

// MARK: - UIView的分类, 先写了放在这里
extension UIView {
    ///< View的x值
    var x: CGFloat {
        set {
            let X = x
            frame.origin.x = X
        }
        get {
            return frame.origin.x
        }
    }
    
    ///< View的y值
    var y: CGFloat {
        set {
            let Y = y
            frame.origin.y = Y
        }
        get {
            return frame.origin.y
        }
    }
    ///< View的宽度
    var width: CGFloat {
        set {
            let W = width
            frame.size.width = W
        }
        get {
            return frame.width
        }
    }
    ///< View的高度
    var height: CGFloat {
        set {
            let H = height
            frame.size.height = H
        }
        get {
            return frame.height
        }
    }
}
