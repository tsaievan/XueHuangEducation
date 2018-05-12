//
//  XHClearCacheManager.swift
//  
//
//  Created by tsaievan on 12/5/18.
//


import UIKit

let fileManager = FileManager.default

let XHClearCache = XHClearCacheManager.shared

typealias XHClearCacheSuccess = () -> ()
typealias XHClearCacheFailue = (String) -> ()

class XHClearCacheManager {
    
    ///< 缓存的大小
    var cacheSize: Double = 0
    
    static let shared = XHClearCacheManager()
    
    var cachePath: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last else {
            return String.empty
        }
        return path
    }
}


extension XHClearCacheManager {
    ///< 计算单个文件的大小
    fileprivate func fileSize(atPath: String) -> Double {
        if fileManager.fileExists(atPath: atPath) {
            guard let attr = try? fileManager.attributesOfItem(atPath: atPath),
                let size = attr[.size] as? Double else {
                    return Double(CGFloat.zero)
            }
            return size / 1024.0 / 1024.0
        }
        return Double(CGFloat.zero)
    }
    
    ///< 计算缓存文件的大小
    func getCacheSize() -> Double {
        cacheSize = 0
        guard let enumerator = fileManager.enumerator(atPath: cachePath) else {
            return Double(CGFloat.zero)
        }
        for (_, subPath) in enumerator.enumerated() {
            guard let subP = subPath as? String else {
                continue
            }
            let path = (cachePath as NSString).appendingPathComponent(subP)
            cacheSize += fileSize(atPath: path)
        }
        return cacheSize
    }
    
    ///< 异步操作清除缓存文件
    func clearCache(success: XHClearCacheSuccess?, failue: XHClearCacheFailue?) {
        DispatchQueue.global().async {
            guard let enumerator = fileManager.enumerator(atPath: self.cachePath) else {
                failue?("清除失败")
                return
            }
            for (_, subPath) in enumerator.enumerated() {
                guard let subP = subPath as? String else {
                    failue?("清除失败")
                    continue
                }
                let path = (self.cachePath as NSString).appendingPathComponent(subP)
                if fileManager.fileExists(atPath: path) {
                    do {
                        try fileManager.removeItem(atPath: path)
                    }catch {
                        
                    }
                }
            }
            success?()
        }
    }
}
