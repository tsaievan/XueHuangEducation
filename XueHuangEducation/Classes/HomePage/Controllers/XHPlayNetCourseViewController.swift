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
        guard let videoStr = videoUrl,
        let url = URL(string: videoStr) else {
            return
        }
        player = AVPlayer(url: url)
        showsPlaybackControls = true
        videoGravity = AVLayerVideoGravity.resizeAspect.rawValue
    }
}
