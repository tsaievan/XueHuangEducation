//
//  XHAlertHUD.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SVProgressHUD

typealias XHAlertHUDDismissCompletion = () -> ()

class XHAlertHUD {
    
    class func showError(withStatus: String?) {
        SVProgressHUD.showError(withStatus: withStatus)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    class func showSuccess(withStatus: String?) {
        SVProgressHUD.showSuccess(withStatus: withStatus);
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    class func showSuccess(withStatus: String?, completion: XHAlertHUDDismissCompletion?) {
        SVProgressHUD.showSuccess(withStatus: withStatus)
        SVProgressHUD.dismiss(withDelay: 2, completion: completion)
    }
    
    class func show(timeInterval: TimeInterval) {
        SVProgressHUD.show()
        if timeInterval <= 0 {
            return
        }
        SVProgressHUD.dismiss(withDelay: timeInterval)
    }
    
    class func showStatus(status: String, timeInterval: TimeInterval) {
        SVProgressHUD.show(withStatus: status)
        if timeInterval <= 0 {
            return
        }
        SVProgressHUD.dismiss(withDelay: timeInterval)
    }
    
    class func isVisible() -> Bool {
        return SVProgressHUD.isVisible()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
}
