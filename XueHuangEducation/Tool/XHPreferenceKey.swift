//
//  XHPreferenceKey.swift
//  XueHuangEducation
//
//  Created by tsaievan on 21/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

final class XHPreferenceKey<T>: PreferenceKeys {}

class PreferenceKeys: RawRepresentable, Hashable {
    let rawValue: String
    
    required init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    convenience init(_ key: String) {
        self.init(rawValue: key)!
    }
    
    var hashValue: Int {
        return rawValue.hashValue
    }
}

extension PreferenceKeys {
    static let USERDEFAULT_GET_PASSWORD_RESULT_KEY = XHPreferenceKey<XHGetPasswordResult>("USERDEFAULT_GET_PASSWORD_RESULT_KEY")
    static let USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY = XHPreferenceKey<XHLoginMember>("USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY")
    static let USERDEFAULT_LOGIN_ACCOUNT = XHPreferenceKey<String>("USERDEFAULT_LOGIN_ACCOUNT")
    static let USERDEFAULT_LOGIN_MOBILE = XHPreferenceKey<String>("USERDEFAULT_LOGIN_MOBILE")
    static let HOMEPAGE_TOTAL_DATA_KEY = XHPreferenceKey<[[Any]]>("HOMEPAGE_TOTAL_DATA_KEY")
}
