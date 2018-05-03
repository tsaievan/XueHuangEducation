//
//  XHQuestionViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHQuestionViewController: XHTableViewController {
    
    var dataSource: [XHCourseCatalog]?
    
    lazy var headerView: XHQuestionHeaderView = {
        let header = XHQuestionHeaderView()
        return header
    }()
    
    var info: (response: [XHCourseCatalog], titleText: String?)? {
        didSet {
            guard let modelInfo = info else {
                return
            }
            dataSource = modelInfo.response
            headerView.title = modelInfo.titleText
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        tableView.register(XHQuestionListCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_QUESTION_LIST)
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - Table view 数据源和代理方法    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataSource?.count else {
            return 0
        }
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_QUESTION_LIST, for: indexPath) as? XHQuestionListCell,
            let datas = dataSource else {
                return UITableViewCell()
        }
        cell.model = datas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
