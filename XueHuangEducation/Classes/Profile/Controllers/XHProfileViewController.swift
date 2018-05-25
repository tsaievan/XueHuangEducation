//
//  XHProfileViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import UserNotifications

enum XHProfileCellSelectType: Int {
    case clearCache = 2
    case about = 3
    case version = 4
}

extension UIEdgeInsets {
    struct ProfileViewController {
        ///< tableView的缩进
        static let tableView = UIEdgeInsetsMake(100, 0, 0, 0)
    }
}

class XHProfileViewController: XHBaseViewController {
    
    var currentVersion: String = "1.1.0"
    
    var dataInfo: [XHProfileInfoModel] {
        let cacheSize = XHClearCache.getCacheSize()
        let cacheString = String(format: "(%.2fM)", cacheSize)
        if let infoDict = Bundle.main.infoDictionary,
            let version = infoDict["CFBundleShortVersionString"] as? String {
            currentVersion = version
        }
        
        let dictArray = [
            ["title" : "允许2G/3G/4G网络下缓存视频",
             "accessory" : XHProfileCellAccessoryType.xhSwitch,
             "switchIsOn" : XHPreferences[.USERDEFAULT_SWICH_ALLOW_CACHE_VIDEO_KEY]],
            ["title" : "允许消息推送",
             "accessory" : XHProfileCellAccessoryType.xhSwitch,
             "switchIsOn" : XHPreferences[.USERDEFAULT_SWICH_ALLOW_PUSH_INFO_KEY]],
            ["title" : "清除缓存" + cacheString,
             "accessory" : XHProfileCellAccessoryType.arrow],
            ["title" : "关于学煌",
             "accessory" : XHProfileCellAccessoryType.arrow],
            ["title" : "当前版本号:" + currentVersion,
             "accessory" : XHProfileCellAccessoryType.arrow],
            ]
        var mtArr = [XHProfileInfoModel]()
        for dict in dictArray {
            guard let model = XHProfileInfoModel(JSON: dict) else {
                continue
            }
            mtArr.append(model)
        }
        return mtArr
    }
    
    lazy var profileTableView: XHProfileTableView = {
        let ptv = XHProfileTableView()
        ptv.tableHeaderView = profileView
        ptv.delegate = self
        ptv.dataSource = self
        ptv.separatorInset = UIEdgeInsets.zero
        return ptv
    }()
    
    lazy var profileView: XHProfileView = {
        let pv = XHProfileView(frame: CGRect(x: 0, y: 0, width: XHSCreen.width, height: 470))
        pv.xh_delegate = self
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///< 请求用户的名称
        XHProfile.getMobile(success: { (response) in
            guard let _ = response["userName"] else {
                XHAlertHUD.dismiss()
                XHGlobalLoading.stopLoading()
                let alerVc = UIAlertController(title: "信息", message: "您已经长时间未操作, 请重新登录", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                    ///< 退出登录的时候要把cookie清空
                    HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
                    ///< 将cookie的接受改为一直
                    HTTPCookieStorage.shared.cookieAcceptPolicy = .always
                    XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] = nil
                    let tabBarController = XHTabBarController()
                    UIApplication.shared.keyWindow?.rootViewController = tabBarController
                    ///< 默认选中登录页面
                    tabBarController.selectedIndex = XHViewControllers.login.rawValue
                })
                alerVc.addAction(confirm)
                UIApplication.shared.keyWindow?.rootViewController?.present(alerVc, animated: true, completion: nil)
                return
            }
        }, failue: nil)
    }
}

// MARK: - 设置UI
extension XHProfileViewController {
    fileprivate func setupUI() {
        navigationItem.title = "个人中心"
        view.addSubview(profileTableView)
        makeConstraints()
        profileTableView.register(XHProfileCell.self, forCellReuseIdentifier: "cell")
    }
    
    fileprivate func makeConstraints() {
        profileTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

// MARK: - profileView的代理
extension XHProfileViewController: XHProfileViewDelegate {
    func profileViewdidClickThreeButtons(profileView: XHProfileView, sender: XHButton) {
        
        if sender.tag == XHButtonType.teach.rawValue { ///< 点击我的讲题按钮
            ///< 先弹出讲题列表控制器, 这个地方可以复用
            let teachVc = XHTeachViewController(style: .grouped)
            teachVc.navigationItem.title = "网校讲题"
            teachVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(teachVc, animated: true)
            XHGlobalLoading.startLoading()
            ///< 调用获取个人讲题列表的接口
            XHProfile.getMyMobileNetCourse(withCourseClassId: "", success: { (catalogs, themeModel) in
                XHGlobalLoading.stopLoading()
                teachVc.newInfo = (catalogs, themeModel)
            }) { (error) in
                XHGlobalLoading.stopLoading()
                if error.code == -1 { ///< 表示没有数据
                    let alertVc = UIAlertController(title: "信息", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    let back = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: { (action) in
                        teachVc.navigationController?.popViewController(animated: true)
                    })
                    alertVc.addAction(cancel)
                    alertVc.addAction(back)
                    teachVc.present(alertVc, animated: true, completion: nil)
                }else if error.code == NSURLErrorNotConnectedToInternet { ///< 网络连接失败, 请检查网络
                    XHAlertHUD.showError(withStatus: "网络连接失败, 请检查网络")
                }else { ///< 获取列表失败
                    XHAlertHUD.showError(withStatus: "获取讲题列表失败")
                }
            }
        }
        
        if sender.tag == XHButtonType.theme.rawValue { ///< 点击答题列表按钮
            ///< 先弹出题库列表控制器, 这个地方可以复用
            let themeVc = XHThemeViewController(style: .grouped)
            themeVc.navigationItem.title = "考卷列表"
            themeVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(themeVc, animated: true)
            XHGlobalLoading.startLoading()
            ///< 调用获取题库列表的接口
            XHProfile.getMyMobiePaperList(withCourseClassId: "", success: { (catalogs, paperList) in
                XHGlobalLoading.stopLoading()
                themeVc.newInfo = (catalogs, paperList)
            }, failue: { (error) in
                XHGlobalLoading.stopLoading()
                if error.code == -1 { ///< 表示没有数据
                    let alertVc = UIAlertController(title: "信息", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    let back = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: { (action) in
                        themeVc.navigationController?.popViewController(animated: true)
                    })
                    alertVc.addAction(cancel)
                    alertVc.addAction(back)
                    themeVc.present(alertVc, animated: true, completion: nil)
                }else if error.code == NSURLErrorNotConnectedToInternet { ///< 网络连接失败, 请检查网络
                    XHAlertHUD.showError(withStatus: "网络连接失败, 请检查网络")
                }else { ///< 获取列表失败
                    XHAlertHUD.showError(withStatus: "获取考卷列表失败")
                }
            })
        }
        
        if sender.tag == XHButtonType.answer.rawValue { ///< 点击我的问答按钮
            let questionVc = XHQuestionViewController(style: .grouped)
            questionVc.navigationItem.title = "答疑列表"
            questionVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(questionVc, animated: true)
            XHGlobalLoading.startLoading()
            ///< 调用我的问答列表接口
            XHProfile.getMyMobieQuestionList(withEnterType: XHQuestionEnterType.answer, courseClassId: "", success: { (response, questionList) in
                XHGlobalLoading.stopLoading()
                questionVc.newInfo = (response, questionList)
            }, failue: { (error) in
                XHGlobalLoading.stopLoading()
                if error.code == -1 { ///< 表示没有数据
                    let alertVc = UIAlertController(title: "信息", message: "暂无答疑列表相关数据", preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    let back = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: { (action) in
                        questionVc.navigationController?.popViewController(animated: true)
                    })
                    alertVc.addAction(cancel)
                    alertVc.addAction(back)
                    questionVc.present(alertVc, animated: true, completion: nil)
                }else if error.code == NSURLErrorNotConnectedToInternet { ///< 网络连接失败, 请检查网络
                    XHAlertHUD.showError(withStatus: "网络连接失败, 请检查网络")
                }else { ///< 获取答疑列表失败
                    XHAlertHUD.showError(withStatus: "获取答疑列表失败")
                }
            })
        }
    }
}

// MARK: - ProfileTableView的代理方法和数据源方法
extension XHProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? XHProfileCell else {
            return UITableViewCell()
        }
        cell.model = dataInfo[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        ///< 点击了清除缓存的cell
        if indexPath.row == XHProfileCellSelectType.clearCache.rawValue {
            let alertVc = UIAlertController(title: "警告", message: "清除缓存将会删除已缓存视频, 清除之后将重新缓存, 是否清除?", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.destructive, handler: { (action) in
                XHClearCache.clearCache(success: {
                    XHAlertHUD.showSuccess(withStatus: "清除成功", completion: {
                        self.profileTableView.reloadData()
                    })
                }, failue: { (errorString) in
                    XHAlertHUD.showError(withStatus: errorString)
                })
            })
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            alertVc.addAction(confirm)
            alertVc.addAction(cancel)
            present(alertVc, animated: true, completion: nil)
        }
        
        ///< 点击了关于学煌的cell
        if indexPath.row == XHProfileCellSelectType.about.rawValue {
            let aboutVc = XHAboutViewController()
            aboutVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(aboutVc, animated: true)
        }
        
        ///< 点击了当前版本号的cell
        if indexPath.row == XHProfileCellSelectType.version.rawValue {
            ///< 调用获取版本号的接口
            XHProfile.upgrade(WithCurrentVersion: currentVersion, success: { (response) in
                guard let result = response.result,
                    let urlStr = response.url else {
//                let url = URL(string: urlStr) else { ///< 保留一个转换url的地方
                    return
                }
                if result == true {
                    XHAlertHUD.showStatus(status: "当前已是最新版本", timeInterval: 2)
                }else {
                    let alertVc = UIAlertController(title: "信息", message: "有最新版本, 是否更新 ?", preferredStyle: UIAlertControllerStyle.alert)
                    let update = UIAlertAction(title: "立即更新", style: UIAlertActionStyle.default, handler: { (action) in
                        ///< 跳转到更新的url去
                    })
                    let cancel = UIAlertAction(title: "稍后再说", style: UIAlertActionStyle.destructive, handler: nil)
                    alertVc.addAction(update)
                    alertVc.addAction(cancel)
                    self.present(alertVc, animated: true, completion: nil)
                }
            }, failue: { (error) in
                if error.code == XHNetworkError.Code.connetFailue {
                    XHAlertHUD.showError(withStatus: XHNetworkError.Desription.connectFailue)
                }else {
                    XHAlertHUD.showError(withStatus: XHNetworkError.Desription.commonError)
                }
            })
        }
    }
}

extension XHProfileViewController {
    override func router(withEventName eventName: String, userInfo: [String : Any]) {
        if eventName == EVENT_PROFILE_CELL_SWITCH_ON_AND_OFF {
            guard let cell = userInfo[PROFILE_CELL_FOR_SWITCH] as? XHProfileCell,
            let indexPath = profileTableView.indexPath(for: cell),
            let xhSwitch = userInfo[PROFILE_CELL_SWITCH_SELF] as? UISwitch else {
                return
            }
            if indexPath.row == XHProfileSwithType.cacheVideo.rawValue { ///< 表明触碰了允许网络下缓存视频的开关
                XHPreferences[.USERDEFAULT_SWICH_ALLOW_CACHE_VIDEO_KEY] = xhSwitch.isOn
                if xhSwitch.isOn == false { ///< 表明关闭了2g/3g/4g开关, 这时候要判断是否有wifi, 没有就关掉下载
                    if !XHNetwork.isReachableOnEthernetOrWiFi() {
                        XHDownload.xh_pauseAllDownloads()
                    }
                }else {
                    XHDownload.xh_pauseAllDownloads()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                        XHDownload.xh_resumeAllDownloads()
                    })
                }
            }
            
            if indexPath.row == XHProfileSwithType.pushInfo.rawValue { ///< 表明触碰了允许消息推送的开关
                XHPreferences[.USERDEFAULT_SWICH_ALLOW_PUSH_INFO_KEY] = xhSwitch.isOn
                guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                if xhSwitch.isOn {
                    delegate.startGetPushedNotificationTimer()
                }else {
                    delegate.invaliatedGetPushedNotificationTimer()
                }
            }
        }
    }
}
