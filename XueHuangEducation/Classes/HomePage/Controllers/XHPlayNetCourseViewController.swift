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

extension XHRatio.W_H_R.PlayNetCourseViewController {
    static let playerViewRatio: CGFloat = 9.0/16.0
}

extension String {
    struct PlayNetCourseViewController {
        struct Title {
            static let showVideo = "展示视频"
        }
    }
}

fileprivate let showVideo = String.PlayNetCourseViewController.Title.showVideo

fileprivate let playerViewRatio = XHRatio.W_H_R.PlayNetCourseViewController.playerViewRatio

class XHPlayNetCourseViewController: XHBaseViewController {
    
    var netwareModel: XHNetCourseWare? {
        didSet {
            XHGlobalLoading.stopLoading()
            guard let videoModel = netwareModel,
                let videoString = videoModel.video,
                ///< 防止转换url失败, 必须添加下面的代码
                let newStr = (videoString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
                let url = URL(string: newStr) else {
                    return
            }
            let title = (videoModel.netCoursewareName ?? String.empty) + String.space + (videoModel.teacher ?? String.empty)
            self.navigationItem.title = showVideo
            playerModel.title = title
            playerModel.videoURL = url
            playerView.playerControlView(controlView, playerModel: playerModel)
            playerView.autoPlayTheVideo()
        }
    }

    var model: XHNetCourse? {
        didSet {
            XHGlobalLoading.stopLoading()
            guard let videoModel = model,
                let videoString = videoModel.video,
                ///< 防止转换url失败, 必须添加下面的代码
                let newStr = (videoString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
                let url = URL(string: newStr) else {
                    return
            }
            
            let title = (model?.netCourseName ?? String.empty) + String.space + (model?.courseTeacher ?? String.empty)
            self.navigationItem.title = model?.netCourseName ?? showVideo
            playerModel.title = title
            playerModel.videoURL = url
            playerView.playerControlView(controlView, playerModel: playerModel)
            playerView.autoPlayTheVideo()
        }
    }
    
    // MARK: - 懒加载
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
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        XHGlobalLoading.startLoading()
    }
}


// MARK: - 设置UI
extension XHPlayNetCourseViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .black
        view.addSubview(playerView)
    }
    
    fileprivate func makeConstaints() {
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(XHMargin._20);
            make.left.right.equalTo(view);
            make.height.equalTo(playerView.snp.width).multipliedBy(playerViewRatio)
        }
    }
}




