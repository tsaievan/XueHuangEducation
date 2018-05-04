//
//  XHThemeListController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 3/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHThemeListController: XHTableViewController {
    
    lazy var headerView: XHPaperListHeaderView = {
        let header = XHPaperListHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        return header
    }()
    
    var dataSource: [XHPaperDetail]?
    
    var info:(models: [XHPaperDetail], titleText: String?)? {
        didSet {
            guard let infos = info?.models else {
                return
            }
            dataSource = infos
            headerView.titleText = info?.titleText
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "考卷分类"
        tableView.register(XHPaperListCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_PAPER_LIST)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
    }

    // MARK: - Table view 的数据源方法和代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSource else {
            return 0
        }
        return datas.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_PAPER_LIST, for: indexPath) as? XHPaperListCell,
        let datas = dataSource else {
            return UITableViewCell()
        }
        cell.model = datas[indexPath.row]
        return cell
    }
}
