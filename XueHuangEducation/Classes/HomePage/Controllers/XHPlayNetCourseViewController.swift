//
//  XHPlayNetCourseViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 27/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

extension AppDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        guard let allow = allowRotation else {
            return .portrait
        }
        return allow ? .landscape : .portrait
    }
}

class XHPlayNetCourseViewController: AVPlayerViewController {
    
    var videoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全屏", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didClickFullScreenBarButton))
        


        guard let videoStr = videoUrl as NSString?,
            ///< 防止转换url失败, 必须添加下面的代码
            let newStr = videoStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue),
            let url = URL(string: newStr) else {
                return
        }
        player = AVPlayer(url: url)
        showsPlaybackControls = true
        videoGravity = AVLayerVideoGravity.resizeAspect.rawValue
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}

extension XHPlayNetCourseViewController {
    @objc
    fileprivate func didClickFullScreenBarButton(sender: UIBarButtonItem) {
        if let appdelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appdelegate.allowRotation = true
        }
        sender.title = ""
    }
    
}


