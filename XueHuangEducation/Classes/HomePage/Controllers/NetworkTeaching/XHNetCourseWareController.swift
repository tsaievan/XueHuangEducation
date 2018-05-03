//
//  XHNetCourseWareController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHNetCourseWareController: UITableViewController {
    
    var dataSouce: [XHNetCourseWare]?
    
    var models: [XHNetCourseWare]? {
        didSet {
            guard let infos = models else {
                return
            }
            dataSouce = infos
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(XHNetCourseWareCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_NETCOURSE_WARE)
        ///< 去除多余的分割线
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view 数据源方法和代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSouce else {
            return 0
        }
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_NETCOURSE_WARE, for: indexPath) as? XHNetCourseWareCell,
            let datas = dataSouce else {
                return UITableViewCell()
        }
        cell.model = datas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
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
            XHDecrypt.getDecryptedPlayerUrl(withOriginalUrl: videoUrl, success: { (videoUrlString) in
                model.video = videoUrlString
                playerVc.netwareModel = model
            }, failue: { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }else { ///< 表明是收费课程
           ///< 要先判断是否登录, 没有登录的话要先弹出登录框
            guard let _ = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] else {
                let alertVc = UIAlertController(title: "信息", message: "您好, 此课件需要登录后观看 !", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                ///< 弹出登录界面
                let confirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
                    let loginVc = XHLoginViewController()
                    let loginNav = XHNavigationController(rootViewController: loginVc)
                    self.navigationController?.present(loginNav, animated: true, completion: nil)
                })
                alertVc.addAction(action)
                alertVc.addAction(confirm)
                
                present(alertVc, animated: true, completion: nil)
                return
            }
            
            
        }
    }
}
