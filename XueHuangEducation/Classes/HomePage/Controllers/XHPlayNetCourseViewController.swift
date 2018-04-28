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

class XHPlayNetCourseViewController: AVPlayerViewController {
    
    var videoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
