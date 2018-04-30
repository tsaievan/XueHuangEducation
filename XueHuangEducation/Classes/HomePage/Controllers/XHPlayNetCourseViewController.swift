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
import ZFPlayer

class XHPlayNetCourseViewController: XHBaseViewController {
    
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "image_video_background")
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    var model: XHNetCourse? {
        didSet {
            XHAlertHUD.dismiss()
            imageView.isHidden = true
            guard let videoModel = model,
                let videoString = videoModel.video,
                ///< 防止转换url失败, 必须添加下面的代码
                let newStr = (videoString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
                let url = URL(string: newStr) else {
                    return
            }
            
            let title = (model?.netCourseName ?? "") + " " + (model?.courseTeacher ?? "")
            self.navigationItem.title = model?.netCourseName ?? "展示视频"
            playerModel.title = title
            playerModel.videoURL = url
            playerView.playerControlView(controlView, playerModel: playerModel)
            playerView.autoPlayTheVideo()
        }
    }
    
    lazy var playerView: ZFPlayerView = {
        let pl = ZFPlayerView()
        return pl
    }()
    
    lazy var controlView: ZFPlayerControlView = {
        let ctrl = ZFPlayerControlView()
        return ctrl
    }()
    
    lazy var playerModel: ZFPlayerModel = {
        let model = ZFPlayerModel()
        model.fatherView = view
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        XHAlertHUD.showStatus(status: "正在加载视频", timeInterval: 0)
    }
}


// MARK: - 设置UI
extension XHPlayNetCourseViewController {
    fileprivate func setupUI() {
        
        view.backgroundColor = .black
        view.addSubview(playerView)
        view.addSubview(imageView)
    }
    
    fileprivate func makeConstaints() {
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20);
            make.left.right.equalTo(view);
            make.height.equalTo(playerView.snp.width).multipliedBy(9.0/16.0)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}




