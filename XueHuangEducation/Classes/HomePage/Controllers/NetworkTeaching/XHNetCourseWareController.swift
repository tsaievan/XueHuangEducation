//
//  XHNetCourseWareController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension XHCellReuseIdentifier.NetCourseWareController {
    static let netcourseWare = "CELL_IDENTIFIER_NETCOURSE_WARE"
}

extension String {
    struct NetCourseWareController {
        static let watchAfterLogin = "您好, 此课件需要登录后观看 !"
        static let getPrivilegeFailue = "获取观看视频权限失败"
    }
}

class XHNetCourseWareController: XHTableViewController {
    
    ///< 数据源
    var dataSouce: [XHNetCourseWare]?
    
    ///< 模型赋值
    var models: [XHNetCourseWare]? {
        didSet {
            guard let infos = models else {
                return
            }
            dataSouce = infos
            tableView.reloadData()
        }
    }
    
    // MARK: - 生命周期
    ///< 页面已经加载
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(XHNetCourseWareCell.self, forCellReuseIdentifier: XHCellReuseIdentifier.NetCourseWareController.netcourseWare)
        ///< 去除多余的分割线
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Table view 数据源方法和代理方法
extension XHNetCourseWareController {
    
    ///< 返回组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return oneSection
    }
    
    ///< 返回行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSouce else {
            return noData
        }
        return datas.count
    }
    
    ///< 返回cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: XHCellReuseIdentifier.NetCourseWareController.netcourseWare, for: indexPath) as? XHNetCourseWareCell,
            let datas = dataSouce else {
                return UITableViewCell()
        }
        cell.model = datas[indexPath.row]
        return cell
    }
    
    ///< 返回行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    ///< 点击cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let datas = dataSouce else {
            return
        }
        let model = datas[indexPath.row]
        guard let type = model.state else {
            return
        }
        
        if type == XHNetCourseWareState.free.rawValue { ///< 表明是试听课程
            guard let videoUrl = model.video else {
                return
            }
            let playerVc = XHPlayNetCourseViewController()
            navigationController?.pushViewController(playerVc, animated: true)
            XHGlobalLoading.startLoading()
            XHDecrypt.getDecryptedPlayerUrl(withOriginalUrl: videoUrl, decryptedType: XHDecryptedType.play, success: {[weak playerVc, weak model] (videoUrlString) in
                XHGlobalLoading.stopLoading()
                model?.video = videoUrlString
                playerVc?.netwareModel = model
                playerVc?.originalVideo = videoUrl
                }, failue: { (errorReason) in
                    XHGlobalLoading.stopLoading()
                    XHAlertHUD.showError(withStatus: errorReason)
                    playerVc.originalVideo = videoUrl
                    playerVc.showNavigationBar()
                    playerVc.playCachedVideo()
            })
        }else { ///< 表明是收费课程
            ///< 要先判断是否登录, 没有登录的话要先弹出登录框
            guard let _ = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] else {
                let alertVc = UIAlertController(title: String.Alert.info.rawValue, message: String.NetCourseWareController.watchAfterLogin, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: String.Alert.cancel.rawValue, style: UIAlertActionStyle.destructive, handler: nil)
                ///< 弹出登录界面
                let confirm = UIAlertAction(title: String.Alert.confirm.rawValue, style: UIAlertActionStyle.default, handler: { (action) in
                    let loginVc = XHLoginViewController()
                    let loginNav = XHNavigationController(rootViewController: loginVc)
                    self.navigationController?.present(loginNav, animated: true, completion: nil)
                })
                alertVc.addAction(action)
                alertVc.addAction(confirm)
                present(alertVc, animated: true, completion: nil)
                return
            }
            guard let netCoursewareId = model.netCoursewareId else {
                return
            }
            XHTeach.isAllowedWatchVideo(withCourseId: netCoursewareId, success: { (isAllowedWatch) in
                guard let success = isAllowedWatch.success else {
                    return
                }
                if success == true { ///< 这个是有看视频的权限的
                    guard let videoUrl = model.video else {
                        return
                    }
                    let playerVc = XHPlayNetCourseViewController()
                    self.navigationController?.pushViewController(playerVc, animated: true)
                    XHGlobalLoading.startLoading()
                    XHDecrypt.getDecryptedPlayerUrl(withOriginalUrl: videoUrl, decryptedType: XHDecryptedType.play, success: {[weak playerVc] (videoUrlString) in
                        XHGlobalLoading.stopLoading()
                        model.video = videoUrlString
                        playerVc?.netwareModel = model
                        playerVc?.originalVideo = videoUrl
                        }, failue: { (errorReason) in
                            XHGlobalLoading.stopLoading()
                            XHAlertHUD.showError(withStatus: errorReason)
                            playerVc.originalVideo = videoUrl
                            playerVc.showNavigationBar()
                            playerVc.playCachedVideo()
                    })
                }else {
                    let message = isAllowedWatch.msg ?? String.NetCourseWareController.getPrivilegeFailue
                    let alertVc = UIAlertController(title: String.Alert.info.rawValue, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    let action = UIAlertAction(title: String.Alert.cancel.rawValue, style: UIAlertActionStyle.destructive, handler: nil)
                    ///< 弹出登录界面
                    let confirm = UIAlertAction(title: String.Alert.confirm.rawValue, style: UIAlertActionStyle.default, handler: nil)
                    alertVc.addAction(action)
                    alertVc.addAction(confirm)
                    self.present(alertVc, animated: true, completion: nil)
                }
            }, failue: { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
    }
}

extension XHNetCourseWareController {
    @objc
    override func router(withEventName eventName: String, userInfo: [String : Any]) {
        guard let cell = userInfo[CELL_FOR_NETCOURSE_WARE_CELL_LISTEN_BUTTON] as? XHNetCourseWareCell,
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        guard let datas = dataSouce else {
            return
        }
        let model = datas[indexPath.row]
        guard let type = model.state else {
            return
        }
        
        if type == XHNetCourseWareState.free.rawValue { ///< 表明是试听课程
            guard let videoUrl = model.video else {
                return
            }
            let playerVc = XHPlayNetCourseViewController()
            navigationController?.pushViewController(playerVc, animated: true)
            XHGlobalLoading.startLoading()
            XHDecrypt.getDecryptedPlayerUrl(withOriginalUrl: videoUrl, decryptedType: XHDecryptedType.play, success: {[weak playerVc, weak model] (videoUrlString) in
                XHGlobalLoading.stopLoading()
                model?.video = videoUrlString
                playerVc?.netwareModel = model
                playerVc?.originalVideo = videoUrl
                }, failue: { (errorReason) in
                    XHGlobalLoading.stopLoading()
                    XHAlertHUD.showError(withStatus: errorReason)
                    playerVc.originalVideo = videoUrl
                    playerVc.showNavigationBar()
                    playerVc.playCachedVideo()
            })
        }else { ///< 表明是收费课程
            ///< 要先判断是否登录, 没有登录的话要先弹出登录框
            guard let _ = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] else {
                let alertVc = UIAlertController(title: String.Alert.info.rawValue, message: String.NetCourseWareController.watchAfterLogin, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: String.Alert.cancel.rawValue, style: UIAlertActionStyle.destructive, handler: nil)
                ///< 弹出登录界面
                let confirm = UIAlertAction(title: String.Alert.confirm.rawValue, style: UIAlertActionStyle.default, handler: { (action) in
                    let loginVc = XHLoginViewController()
                    let loginNav = XHNavigationController(rootViewController: loginVc)
                    self.navigationController?.present(loginNav, animated: true, completion: nil)
                })
                alertVc.addAction(action)
                alertVc.addAction(confirm)
                present(alertVc, animated: true, completion: nil)
                return
            }
            guard let netCoursewareId = model.netCoursewareId else {
                return
            }
            XHTeach.isAllowedWatchVideo(withCourseId: netCoursewareId, success: { (isAllowedWatch) in
                guard let success = isAllowedWatch.success else {
                    return
                }
                if success == true { ///< 这个是有看视频的权限的
                    guard let videoUrl = model.video else {
                        return
                    }
                    let playerVc = XHPlayNetCourseViewController()
                    self.navigationController?.pushViewController(playerVc, animated: true)
                    XHGlobalLoading.startLoading()
                    XHDecrypt.getDecryptedPlayerUrl(withOriginalUrl: videoUrl, decryptedType: XHDecryptedType.play, success: {[weak playerVc] (videoUrlString) in
                        XHGlobalLoading.stopLoading()
                        model.video = videoUrlString
                        playerVc?.netwareModel = model
                        playerVc?.originalVideo = videoUrl
                        }, failue: { (errorReason) in
                            XHGlobalLoading.stopLoading()
                            XHAlertHUD.showError(withStatus: errorReason)
                            playerVc.originalVideo = videoUrl
                            playerVc.showNavigationBar()
                            playerVc.playCachedVideo()
                    })
                }else {
                    let message = isAllowedWatch.msg ?? String.NetCourseWareController.getPrivilegeFailue
                    let alertVc = UIAlertController(title: String.Alert.info.rawValue, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    let action = UIAlertAction(title: String.Alert.cancel.rawValue, style: UIAlertActionStyle.destructive, handler: nil)
                    ///< 弹出登录界面
                    let confirm = UIAlertAction(title: String.Alert.confirm.rawValue, style: UIAlertActionStyle.default, handler: nil)
                    alertVc.addAction(action)
                    alertVc.addAction(confirm)
                    self.present(alertVc, animated: true, completion: nil)
                }
            }, failue: { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
    }
}


