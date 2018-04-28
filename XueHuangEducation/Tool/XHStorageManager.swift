//
//  XHStorageManager.swift
//  XueHuangEducation
//
//  Created by tsaievan on 28/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import Cache

let XHStorage = XHStorageManager.shared.storage

class XHStorageManager: NSObject {
    
    ///< 单例
    static let shared = XHStorageManager()
    
    let diskConfig = DiskConfig(name: XH_DEFAULT_DISK_CACHE)
    
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
    
    var storage: Storage?
    
    override init() {
        super.init()
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        }catch {
            print(error)
        }
    }
}

