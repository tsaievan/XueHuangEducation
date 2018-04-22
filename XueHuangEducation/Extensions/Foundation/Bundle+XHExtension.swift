//
//  Bundle+XHExtension.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension Bundle {
    class var bundleName: String? {
        guard let infoDict = Bundle.main.infoDictionary,
        let name = infoDict["CFBundleName"] as? String else {
            return nil
        }
        return name
    }
}
