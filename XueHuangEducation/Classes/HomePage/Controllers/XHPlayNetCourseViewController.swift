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
import ZFDownload

let downloadUrl = "http://120.77.242.84:8083/xhweb/appController.do?getDecryptDownloadMp4Url&encryptMp4Url="

extension XHRatio.W_H_R.PlayNetCourseViewController {
    static let playerViewRatio: CGFloat = 9.0/16.0
}

extension String {
    struct PlayNetCourseViewController {
        struct Title {
            static let showVideo = "展示视频"
        }
        
        struct Path {
            static let downloadPath = "ZFDownLoad/CacheList"
        }
    }
}

fileprivate let showVideo = String.PlayNetCourseViewController.Title.showVideo

fileprivate let downloadPath = String.PlayNetCourseViewController.Path.downloadPath

fileprivate let playerViewRatio = XHRatio.W_H_R.PlayNetCourseViewController.playerViewRatio




class XHPlayNetCourseViewController: UIViewController {
    
    var originalVideo: String?
    
    var netwareModel: XHNetCourseWare? {
        didSet {
            XHGlobalLoading.stopLoading()
            guard let videoModel = netwareModel,
                let videoString = videoModel.video,
                ///< 防止转换url失败, 必须添加下面的代码
                let newStr = (videoString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
                var url = URL(string: newStr) else {
                    return
            }
            ZFDownloadManager.shared().finishedlist.forEach({ (fileModel) in
                if let file = fileModel as? ZFFileModel,
                    let name = file.fileName {
                    ///< 文件名一致, 且下载完成
                    if name == url.lastPathComponent {
                        let str = String(format: "%@/%@/%@", XHClearCache.cachePath, downloadPath, name)
                        url = URL(fileURLWithPath: str)
                        
                    }
                }
            })
            
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
                var url = URL(string: newStr) else {
                    return
            }
            ZFDownloadManager.shared().finishedlist.forEach({ (fileModel) in
                if let file = fileModel as? ZFFileModel,
                    let name = file.fileName {
                    ///< 文件名一致, 且下载完成
                    if name == url.lastPathComponent {
                        let str = String(format: "%@/%@/%@", XHClearCache.cachePath, downloadPath, name)
                        url = URL(fileURLWithPath: str)
                        
                    }
                }
            })
            let title = (model?.netCourseName ?? String.empty) + String.space + (model?.courseTeacher ?? String.empty)
            self.navigationItem.title = model?.netCourseName ?? showVideo
            playerModel.title = title
            playerModel.videoURL = url
            playerView.playerControlView(controlView, playerModel: playerModel)
            playerView.autoPlayTheVideo()
        }
    }
    
    lazy var playerFatherView: UIView = {
        let v = UIView()
        view.addSubview(v)
        v.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(XHMargin._20)
            make.width.equalTo(XHSCreen.width)
            make.height.equalTo(XHSCreen.width).multipliedBy(XHRatio.W_H_R.PlayNetCourseViewController.playerViewRatio)
        })
        view.layoutIfNeeded()
        return v
    }()
    
    // MARK: - 懒加载
    lazy var playerView: ZFPlayerView = {
        let pl = ZFPlayerView()
        pl.delegate = self
        return pl
    }()
    
    lazy var controlView: ZFPlayerControlView = {
        let ctrl = ZFPlayerControlView()
        ctrl.zf_playerHasDownloadFunction(true)
        return ctrl
    }()
    
    lazy var playerModel: ZFPlayerModel = {
        let model = ZFPlayerModel()
        model.fatherView = playerFatherView
        return model
    }()
    
    lazy var downloadButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .yellow
        return btn
    }()
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        XHGlobalLoading.startLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    ///< 必须重写这个方法, 不然全屏之后返回会有问题
    override var shouldAutorotate: Bool {
        return false
    }
}


// MARK: - 设置UI
extension XHPlayNetCourseViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .black
    }
}

// MARK: - ZFPlayerDelegate代理方法
extension XHPlayNetCourseViewController: ZFPlayerDelegate {
    ///< 下载视频的代理回调
    func zf_playerDownload(_ url: String!) {
        let downloader = ZFDownloadManager.shared()
        let name = playerModel.videoURL.lastPathComponent
        
        guard let originalUrlStr = originalVideo else {
            return
        }
        ///< 对原始的url字符串进行处理
        let fullUrl = downloadUrl + originalUrlStr
        ///< 一定要做下面这一步, 不然生成URL失败
        let newStr = (fullUrl as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue)
        downloader?.downFileUrl(newStr, filename: name, fileimage: nil)
        ///< 设置最大下载并发数为4
        downloader?.maxCount = 4
    }
    
    func zf_playerBackAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - 其他事件
///< 没网情况下显示navigationBar
extension XHPlayNetCourseViewController {
    func showNavigationBar() {
        ///< 不知道为什么下面的方法不行
        //        navigationController?.setNavigationBarHidden(false, animated: false)
        ///< 直接设置isHidden属性是可以的
        navigationController?.navigationBar.isHidden = false
    }
}




