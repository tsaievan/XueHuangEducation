//
//  XHPreferenceManager.swift
//  XueHuangEducation
//
//  Created by tsaievan on 21/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

///< 定义一个全局的偏好设置工具
let XHPreferences = XHPreferenceManager.shared

final class XHPreferenceManager {
    static let shared = XHPreferenceManager()
    let defaults = UserDefaults.standard
}

extension XHPreferenceManager {
    
    subscript(key: XHPreferenceKey<Any>) -> Any? {
        get {
            return defaults.object(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<URL>) -> URL? {
        get {
            return defaults.url(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<[Any]>) -> [Any]? {
        get {
            return defaults.array(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<[String : Any]>) -> [String : Any]? {
        get {
            return defaults.dictionary(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<String>) -> String? {
        get {
            return defaults.string(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<[String]>) -> [String]? {
        get {
            return defaults.stringArray(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<Data>) -> Data? {
        get {
            return defaults.data(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<Bool>) -> Bool {
        get {
            return defaults.bool(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<Int>) -> Int {
        get {
            return defaults.integer(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<Float>) -> Float {
        get {
            return defaults.float(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<Double>) -> Double {
        get {
            return defaults.double(forKey: key.rawValue)
        }
        set {
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    subscript(key: XHPreferenceKey<XHGetPasswordResult>) -> XHGetPasswordResult? {
        get {
            var object: XHGetPasswordResult?
            if let data = defaults.data(forKey: key.rawValue) {
                object = NSKeyedUnarchiver.unarchiveObject(with: data) as? XHGetPasswordResult
            }
            return object
        }
        set {
            if let object = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: object)
                defaults.set(data, forKey: key.rawValue)
            }else {
                defaults.removeObject(forKey: key.rawValue)
            }
        }
    }
    
    subscript(key: XHPreferenceKey<XHLoginMember>) -> XHLoginMember? {
        get {
            var object: XHLoginMember?
            if let data = defaults.data(forKey: key.rawValue) {
                object = NSKeyedUnarchiver.unarchiveObject(with: data) as? XHLoginMember
            }
            return object
        }
        set {
            if let object = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: object)
                defaults.set(data, forKey: key.rawValue)
            }else {
                defaults.removeObject(forKey: key.rawValue)
            }
        }
    }
    
    subscript(key: XHPreferenceKey<[[Any]]>) -> [[Any]]? {
        get {
            var object: [[Any]]?
            if let data = defaults.data(forKey: key.rawValue) {
                object = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Any]]
            }
            return object
        }
        set {
            if let object = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: object)
                defaults.set(data, forKey: key.rawValue)
            }else {
                defaults.removeObject(forKey: key.rawValue)
            }
        }
    }
}
