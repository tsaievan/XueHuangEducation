//
//  XHHomePageViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit

class XHHomePageViewController: XHBaseViewController {
    
    var dataSource: [[Any]]?
    
    lazy var tableView: XHTableView = {
        let t = XHTableView(frame: .zero, style: .grouped)
        ///< 取出分割线
        t.separatorStyle = .none
        t.dataSource = self
        t.delegate = self
        return t
    }()
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        XHAlertHUD.show(timeInterval: 0)
        XHHomePage.getHomePageList(success: { (data) in
            XHAlertHUD.dismiss()
            self.dataSource = data
            self.tableView.reloadData()
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
        }
        tableView.register(XHCourseCatalogCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_HOMEPAGE_CATALOG)
        tableView.register(XHNetCourseCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_HOMEPAGE_NETCOURSE)
    }
    
    override func router(withEventName eventName: String, userInfo: [String : Any]) {
        ///< 点击了分类的按钮
        if eventName == EVENT_CLICK_CATALOG_BUTTON {
            guard let model = userInfo[MODEL_CLICK_CATALOG_BUTTON] as? XHCourseCatalog else {
                return
            }
        }
        
        ///< 点击推荐课程/热门课程的按钮
        if eventName == EVENT_CLICK_COURSE_BUTTON {
            guard let model = userInfo[MODEL_CLICK_COURSE_BUTTON] as? XHNetCourse,
            let videoUrl = model.video else {
                return
            }
            print("\(videoUrl)")
            let url = URL(string: videoUrl)
            let webVc = XHShowNetCourseViewController()
            webVc.hidesBottomBarWhenPushed = true
            webVc.videoUrl = url
            navigationController?.pushViewController(webVc, animated: true)
        }
    }
}

extension XHHomePageViewController {
    fileprivate func setupUI() {
        navigationItem.title = "学煌教育网"
        view.backgroundColor = .white
        view.addSubview(tableView)
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
