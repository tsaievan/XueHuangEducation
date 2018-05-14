//
//  XHHomePageViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

extension AppDelegate {
    ///< 在app刚启动时就开始隐式加载数据
    func downloadHomepageData() {
        XHGlobalLoading.startLoading()
        XHHomePage.getHomePageList(success: { (data) in
            XHPreferences[.HOMEPAGE_TOTAL_DATA_KEY] = data
            NotificationCenter.default.post(name: NSNotification.Name.XHDownloadHomePageData.success, object: self, userInfo: [KEY_DOWNLOAD_HOME_PAGE_SUCCESS_DATA : data])
        }) { (errorReason) in
            NotificationCenter.default.post(name: NSNotification.Name.XHDownloadHomePageData.failue, object: self, userInfo: [KEY_DOWNLOAD_HOME_PAGE_FAILUE_DATA : errorReason])
        }
    }
}


class XHHomePageViewController: XHBaseViewController {
    var dataSource: [[Any]]?
    
    lazy var tableView: XHTableView = {
        let t = XHTableView(frame: .zero, style: .grouped)
        ///< 取出分割线
        t.separatorStyle = .none
        t.showsVerticalScrollIndicator = false
        t.showsHorizontalScrollIndicator = false
        t.dataSource = self
        t.delegate = self
        
        ///< 设置上下拉刷新的事件
        t.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullToRefreshAction))
        return t
    }()
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(downloadHomePageDataSuccess), name: NSNotification.Name.XHDownloadHomePageData.success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(downloadHomePageDataFailue), name: NSNotification.Name.XHDownloadHomePageData.failue, object: nil)
        if let data = XHPreferences[.HOMEPAGE_TOTAL_DATA_KEY] {
            dataSource = data
            tableView.reloadData()
        }
    }
    
    override func router(withEventName eventName: String, userInfo: [String : Any]) {
        ///< 点击了分类的按钮
        if eventName == EVENT_CLICK_CATALOG_BUTTON {
            guard let model = userInfo[MODEL_CLICK_CATALOG_BUTTON] as? XHCourseCatalog else {
                return
            }
            let catalogVc = XHCatalogListViewController()
            catalogVc.model = model
            catalogVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(catalogVc, animated: true)
            XHGlobalLoading.startLoading()
        }
        
        ///< 点击推荐课程/热门课程的按钮
        if eventName == EVENT_CLICK_COURSE_BUTTON {
            guard let model = userInfo[MODEL_CLICK_COURSE_BUTTON] as? XHNetCourse,
            let cell = userInfo[CELL_FOR_COURSE_BUTTON] as? XHNetCourseCell,
            let videoUrl = model.video,
            let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            if indexPath.section == 1 { ///< 推荐课程
                let url = URL(string: videoUrl)
                let webVc = XHShowNetCourseViewController()
                webVc.hidesBottomBarWhenPushed = true
                webVc.webUrl = url
                navigationController?.pushViewController(webVc, animated: true)
                XHGlobalLoading.startLoading()
            }
            
            if indexPath.section == 2 { ///< 热门课程
                let playerVc = XHPlayNetCourseViewController()
                playerVc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(playerVc, animated: true)
                XHGlobalLoading.startLoading()
                XHDecrypt.getDecryptedPlayerUrl(withOriginalUrl: videoUrl, success: {(videoUrlString) in
                    XHGlobalLoading.stopLoading()
                    model.video = videoUrlString
                    playerVc.model = model
                }, failue: { (errorReason) in
                    XHGlobalLoading.stopLoading()
                    XHAlertHUD.showError(withStatus: errorReason)
                    playerVc.showNavigationBar()
                })
            }
        }
    }
}

// MARK: - 设置UI
extension XHHomePageViewController {
    fileprivate func setupUI() {
        navigationItem.title = "学煌教育网"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(XHCourseCatalogCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_HOMEPAGE_CATALOG)
        tableView.register(XHNetCourseCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_HOMEPAGE_NETCOURSE)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

// MARK: - tableView的代理和数据源方法
extension XHHomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = dataSource?.count else {
            return 1
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        guard let dataArray = dataSource else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_HOMEPAGE_CATALOG, for: indexPath)
            guard let newCell = cell as? XHCourseCatalogCell,
            let catalogs = dataArray[indexPath.section] as? [XHCourseCatalog] else {
                return UITableViewCell()
            }
            newCell.catalogs = catalogs
            return newCell
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_HOMEPAGE_NETCOURSE, for: indexPath)
            guard let newCell = cell as? XHNetCourseCell,
                let catalogs = dataArray[indexPath.section] as? [XHNetCourse] else {
                    return UITableViewCell()
            }
            newCell.catalogs = catalogs
            return newCell
        }
    }
    
    ///< 把广告view放到这里
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = XHCourseCatalogSectionHeaderView()
            guard let data = dataSource else {
                return headerView
            }
            headerView.models = data[section] as? [XHCourseCatalog]
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = XHCourseCatalogSectionFooterView()
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        }
        return 0.01
    }
    
    ///< 点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///< 取消选中
        tableView.deselectRow(at: indexPath, animated: false)
    }   
}

// MARK: - 处理通知事件
extension XHHomePageViewController {
    @objc
    fileprivate func downloadHomePageDataSuccess(notification: Notification) {
        XHGlobalLoading.stopLoading()
        guard let info = notification.userInfo,
        let data = info[KEY_DOWNLOAD_HOME_PAGE_SUCCESS_DATA] as? [[Any]] else {
            return
        }
        dataSource = data
        tableView.reloadData()
    }
    
    @objc
    fileprivate func downloadHomePageDataFailue(notification: Notification) {
        XHGlobalLoading.stopLoading()
        guard let info = notification.userInfo,
            let errorReason = info[KEY_DOWNLOAD_HOME_PAGE_FAILUE_DATA] as? String else {
                return
        }
        tableView.reloadData()
        XHAlertHUD.showError(withStatus: errorReason)
    }
}

// MARK: - 事件处理
extension XHHomePageViewController {
    
    ///< 下拉刷新
    @objc
    fileprivate func pullToRefreshAction() {
        XHHomePage.getHomePageList(success: { (data) in
            self.tableView.mj_header.endRefreshing()
            self.dataSource = data
            self.tableView.reloadData()
        }) { (errorReason) in
            self.tableView.mj_header.endRefreshing()
            XHAlertHUD.showError(withStatus: errorReason)
            if let data = XHPreferences[.HOMEPAGE_TOTAL_DATA_KEY] {
                self.dataSource = data
                self.tableView.reloadData()
            }
        }
    }
}
