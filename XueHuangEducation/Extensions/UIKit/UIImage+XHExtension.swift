//
//  UIImage+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIImage {
    ///< 制作一张纯色的图片
    class func image(withPureColor pureColor: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        pureColor.set()
        UIRectFill(CGRect(origin: .zero, size: size))
        let renderImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return renderImage
    }
}
