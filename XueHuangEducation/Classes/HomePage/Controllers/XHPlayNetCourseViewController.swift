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
    
    ///< 当前正在下载的文件
    var currentFileInfo: ZFFileModel?
    
    var currentRequest: ZFHttpRequest?
    
    var originalVideo: String?
    
    var netwareModel: XHNetCourseWare? {
        didSet {
            XHGlobalLoading.stopLoading()
            guard let videoModel = netwareModel,
                let videoString = videoModel.video,
                ///< 防止转换url失败, 必须添加下面的代码
                var newStr = (videoString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
                var url = URL(string: newStr) else {
                    return
            }
            ZFDownloadManager.shared().finishedlist.forEach({ (fileModel) in
                if let file = fileModel as? ZFFileModel,
                    let name = file.fileName {
                    ///< 文件名一致, 且下载完成
                    if name == (url.absoluteString as NSString).lastPathComponent {
                        let str = String(format: "%@/%@/%@", XHClearCache.cachePath, downloadPath, name)
                        url = URL(fileURLWithPath: str)
                        downloadButton.setTitle("已缓存", for: .normal)
                        downloadButton.isHidden = false
                    }
                }
            })
            
            XHDownload.downinglist.forEach({ (request) in
                if let req = request as? ZFHttpRequest,
                    let fileInfo = req.userInfo["File"] as? ZFFileModel,
                    let name = fileInfo.fileName {
                    if newStr.contains("nickname") {
                        let stringArr = (newStr as NSString).components(separatedBy: "?nickname")
                        newStr = stringArr.first!
                    }
                    
                    let encodedName = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, newStr as CFString, "!$&'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue) as NSString
                    let encodedFileName = encodedName.lastPathComponent
                    if name == encodedFileName {
                        guard let _ = fileInfo.fileReceivedSize,
                            let _ = fileInfo.fileSize else {
                                return
                        }
                        let received = (fileInfo.fileReceivedSize as NSString).doubleValue
                        let total = (fileInfo.fileSize as NSString).doubleValue
                        var buttonTitle = String.empty
                        if received < total {
                            buttonTitle = String(format: "正在缓存 %.f%@", received * 100 / total, "%")
                            downloadButton.setTitle(buttonTitle, for: .normal)
                            currentFileInfo = fileInfo
                            currentFileInfo!.addObserver(self, forKeyPath: "fileReceivedSize", options: NSKeyValueObservingOptions.new, context: nil)
                            downloadButton.isHidden = false
                        }else {
                            downloadButton.setTitle("已缓存", for: .normal)
                            downloadButton.isHidden = false
                        }
                    }
                }
            })
            
            let title = (videoModel.netCoursewareName ?? String.empty) + String.space + (videoModel.teacher ?? String.empty)
            self.navigationItem.title = showVideo
            playerModel.title = title
            playerModel.videoURL = url
            playerView.playerControlView(controlView, playerModel: playerModel)
//            playerView.autoPlayTheVideo()
        }
    }
    
    var cachedUrl: URL?
    
    var model: XHNetCourse? {
        didSet {
            XHGlobalLoading.stopLoading()
            guard let videoModel = model,
                let videoString = videoModel.video,
                ///< 防止转换url失败, 必须添加下面的代码
                var newStr = (videoString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
                var url = URL(string: newStr) else {
                    return
            }
            ZFDownloadManager.shared().finishedlist.forEach({ (fileModel) in
                if let file = fileModel as? ZFFileModel,
                    let name = file.fileName {
                    ///< 文件名一致, 且下载完成
                    if name == (url.absoluteString as NSString).lastPathComponent  {
                        let str = String(format: "%@/%@/%@", XHClearCache.cachePath, downloadPath, name)
                        url = URL(fileURLWithPath: str)
                        downloadButton.setTitle("已缓存", for: .normal)
                        downloadButton.isHidden = false
                    }
                }
            })
            
            XHDownload.downinglist.forEach({ (request) in
                if let req = request as? ZFHttpRequest,
                    let fileInfo = req.userInfo["File"] as? ZFFileModel,
                    let name = fileInfo.fileName {
                    if newStr.contains("nickname") {
                        let stringArr = (newStr as NSString).components(separatedBy: "?nickname")
                        newStr = stringArr.first!
                    }
                    
                    let encodedName = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, newStr as CFString, "!$&'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue) as NSString
                    let encodedFileName = encodedName.lastPathComponent
                    if name == encodedFileName {
                        guard let _ = fileInfo.fileReceivedSize,
                            let _ = fileInfo.fileSize else {
                                return
                        }
                        let received = (fileInfo.fileReceivedSize as NSString).doubleValue
                        let total = (fileInfo.fileSize as NSString).doubleValue
                        var buttonTitle = String.empty
                        if received < total {
                            buttonTitle = String(format: "正在缓存 %.f%@", received * 100.0 / total, "%")
                            downloadButton.setTitle(buttonTitle, for: .normal)
                            currentFileInfo = fileInfo
                            currentFileInfo!.addObserver(self, forKeyPath: "fileReceivedSize", options: NSKeyValueObservingOptions.new, context: nil)
                            downloadButton.isHidden = false
                        }else {
                            downloadButton.setTitle("已缓存", for: .normal)
                            downloadButton.isHidden = false
                        }
                    }
                }
            })
            let title = (model?.netCourseName ?? String.empty) + String.space + (model?.courseTeacher ?? String.empty)
            self.navigationItem.title = model?.netCourseName ?? showVideo
            playerModel.title = title
            playerModel.videoURL = url
            playerView.playerControlView(controlView, playerModel: playerModel)
//            playerView.autoPlayTheVideo()
        }
    }
    
    lazy var playerFatherView: UIView = {
        let v = UIView()
        view.addSubview(v)
        v.snp.makeConstraints({ (make) in
            make.left.equalTo(view)
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
        btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat.FontSize._12)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        btn.backgroundColor = .clear
        btn.layer.borderColor = COLOR_BUTTON_BORDER_DOWNLOAD_PROGRESS_PINK.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.isHidden = true
        return btn
    }()
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        XHGlobalLoading.startLoading()
        //        XHDownload.downloadDelegate = self
        XHDownload.downloadDelegate = self
        XHDownload.downinglist.forEach { (request) in
            if let req = request as? ZFHttpRequest,
                let fileInfo = req.userInfo["File"] as? ZFFileModel,
                let name = fileInfo.fileName {
                ///< 文件名一致, 且下载完成
                guard var ori = originalVideo else {
                    return
                }
                if ori.contains("nickname") {
                    let stringArr = (ori as NSString).components(separatedBy: "?nickname")
                    ori = stringArr.first!
                }
                
                let encodedName = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, ori as CFString, "!$&'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue) as NSString
                let encodedFileName = encodedName.lastPathComponent
                if name == encodedFileName {
                    let received = (fileInfo.fileReceivedSize as NSString).doubleValue
                    let total = (fileInfo.fileSize as NSString).doubleValue
                    var buttonTitle = String.empty
                    if received < total {
                        buttonTitle = String(format: "正在缓存 %.f%@", received / total, "%")
                        downloadButton.setTitle(buttonTitle, for: .normal)
                        downloadButton.isHidden = false
                    }else {
                        downloadButton.isHidden = true
                    }
                }
            }
        }
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
    
    deinit {
        currentFileInfo?.removeObserver(self, forKeyPath: "fileReceivedSize")
        print("离开XHPlayNetCourseViewController")
    }
}


// MARK: - 设置UI
extension XHPlayNetCourseViewController {
    fileprivate func setupUI() {
        controlView.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { (make) in
            make.right.equalTo(controlView).offset(-8)
            make.bottom.equalTo(controlView).offset(-40)
            make.height.equalTo(30)
        }
        view.backgroundColor = .black
    }
}

// MARK: - ZFPlayerDelegate代理方法
extension XHPlayNetCourseViewController: ZFPlayerDelegate {
    ///< 下载视频的代理回调
    func zf_playerDownload(_ url: String!) {
        ///< 没有wifi且没有打开2G/3G/4G网络下缓存视频的开关
        if !XHNetwork.isReachableOnEthernetOrWiFi() && !XHPreferences[.USERDEFAULT_SWICH_ALLOW_CACHE_VIDEO_KEY] {
            let alertVc = UIAlertController(title: "警告", message: "您尚未开启允许2G/3G/4G网络下缓存视频的开关", preferredStyle: UIAlertControllerStyle.alert)
            let open = UIAlertAction(title: "立即开启", style: UIAlertActionStyle.default, handler: { (action) in
                guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? XHTabBarController else {
                    return
                }
                tabBarController.selectedIndex = 2
            })
            let cancel = UIAlertAction(title: "稍后再说", style: UIAlertActionStyle.destructive, handler: nil)
            alertVc.addAction(open)
            alertVc.addAction(cancel)
            present(alertVc, animated: true, completion: nil)
            return
        }
        
        let name = (url as NSString).lastPathComponent
        var flag: Bool = false
        
        XHDownload.downinglist.forEach { (request) in
            if let req = request as? ZFHttpRequest {
                let printedName = (req.url.absoluteString as NSString).lastPathComponent
                if printedName == name {
                    XHAlertHUD.showStatus(status: "正在缓存中...", timeInterval: 2)
                    flag = true
                    return
                }
            }
        }
        if flag {
            return
        }
        guard var ori = originalVideo else {
            return
        }
        if ori.contains("nickname") {
            let stringArr = (ori as NSString).components(separatedBy: "?nickname")
            ori = stringArr.first!
        }
        let newStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (downloadUrl + ori) as CFString, "!$&'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue) as String
        XHDownload.downFileUrl(newStr, filename: name, fileimage: nil)
        if let net = netwareModel {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                if !self.downloadButton.isHidden {
                    self.downloadButton.isHidden = false
                }
                self.netwareModel = net
            })
        }
        if let m = model {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                if !self.downloadButton.isHidden {
                    self.downloadButton.isHidden = false
                }
                self.model = m
            })
        }
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

extension XHPlayNetCourseViewController {
    ///< 缓存之后, 即时断网也可以查看视频
    func playCachedVideo() {
        ZFDownloadManager.shared().finishedlist.forEach({ (fileModel) in
            if let file = fileModel as? ZFFileModel,
                let name = file.fileName {
                ///< 文件名一致, 且下载完成
                guard var ori = originalVideo else {
                    return
                }
                if ori.contains("nickname") {
                    let stringArr = (ori as NSString).components(separatedBy: "?nickname")
                    ori = stringArr.first!
                }
                
                let encodedName = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, ori as CFString, "!$&'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue) as NSString
                let encodedFileName = encodedName.lastPathComponent
                if name == encodedFileName {
                    let str = String(format: "%@/%@/%@", XHClearCache.cachePath, downloadPath, name)
                    let url = URL(fileURLWithPath: str)
                    playerModel.videoURL = url
                    playerView.playerControlView(controlView, playerModel: playerModel)
//                    playerView.autoPlayTheVideo()
                }
            }
        })
    }
}

extension XHPlayNetCourseViewController {
    @objc
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let fileInfo = currentFileInfo {
            let received = (fileInfo.fileReceivedSize as NSString).doubleValue
            let total = (fileInfo.fileSize as NSString).doubleValue
            var buttonTitle = String.empty
            if received < total {
                buttonTitle = String(format: "正在缓存 %.f%@", received * 100.0 / total, "%")
                downloadButton.setTitle(buttonTitle, for: .normal)
                downloadButton.isHidden = false
            }else {
                downloadButton.isHidden = true
            }
        }
    }
}


// MARK: - 按钮的点击事件
//extension XHPlayNetCourseViewController {
//    @objc
//    fileprivate func didClickDownloadButtonAction(sender: UIButton) {
//        sender.isUserInteractionEnabled = false
//        let name = playerModel.videoURL.lastPathComponent
//        guard let originalUrlStr = originalVideo else {
//            return
//        }
//
//        ///< 对原始的url字符串进行处理
//        let fullUrl = downloadUrl + originalUrlStr
//        ///< 一定要做下面这一步, 不然生成URL失败
//        guard let newStr = (fullUrl as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
//            let newUrl = URL(string: newStr) else {
//                return
//        }
//
//        if XHDownload.downinglist.count > 0 {
//            XHDownload.downinglist.forEach({ (request) in
//                if let request = request as? ZFHttpRequest {
//                    let last = (request.url.absoluteString as NSString).lastPathComponent
//                    let lastStrings = (last as NSString).components(separatedBy: "?nickname=")
//                    var realLast = String.empty
//                    if lastStrings.count > 0 {
//                        realLast = lastStrings.first!
//                    }
//                    if newUrl.absoluteString.contains(realLast) || newUrl == playerModel.videoURL {
//                        currentRequest = request
//
//                        if let fileInfo = request.userInfo["File"] as? ZFFileModel {
//                            if fileInfo.downloadState == .downloading {
//                                if let _ = currentRequest {
//                                    sender.isSelected = true
//                                    XHDownload.stop(currentRequest!)
//                                    sender.isUserInteractionEnabled = true
//                                    return
//                                }
//                            }else {
//                                if let _ = currentRequest {
//                                    sender.isSelected = false
//                                    XHDownload.resumeRequest(currentRequest!)
//                                    sender.isUserInteractionEnabled = true
//                                    return
//                                }
//                            }
//                        }
//                    }
//                }
//            })
//        }else {
//            XHDownload.downFileUrl(newStr, filename: name, fileimage: nil)
//        }
//        sender.isUserInteractionEnabled = true
//    }
//}

extension XHPlayNetCourseViewController: ZFDownloadDelegate {
    func startDownload(_ request: ZFHttpRequest!) {

    }

    func finishedDownload(_ request: ZFHttpRequest!) {

    }

    func updateCellProgress(_ request: ZFHttpRequest!) {
//        guard let curr = currentRequest,
//            let fileInfo = curr.userInfo["File"] else {
//            return
//        }
//        perform(#selector(updateButtonTile), on: Thread.main, with: fileInfo, waitUntilDone: true)
    }
}

//extension XHPlayNetCourseViewController {
//    @objc
//    fileprivate func updateButtonTile(fileInfo: ZFFileModel) {
//        if let recievedString = fileInfo.fileReceivedSize,
//            let totalString = fileInfo.fileSize {
//            let received = (recievedString as NSString).doubleValue
//            let total = (totalString as NSString).doubleValue
//            let ratio = (received / total) * 100
//            let btnTitle = String(format: "%.2f%@", ratio, "%")
//            downloadButton.setTitle(btnTitle, for: .normal)
//            if received >= total {
//                downloadButton.setTitle("已缓存", for: .normal)
//            }
//        }
//    }
//}








