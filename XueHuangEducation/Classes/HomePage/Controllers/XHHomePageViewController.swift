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
        let t = XHTableView()
        t.dataSource = self
        t.delegate = self
        return t
    }()
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        XHHomePage.getHomePageList(success: { (data) in
            self.dataSource = data
            self.tableView.reloadData()
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
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
        guard let data = dataSource else {
            return 0
        }
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    ///< 把广告view放到这里
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
