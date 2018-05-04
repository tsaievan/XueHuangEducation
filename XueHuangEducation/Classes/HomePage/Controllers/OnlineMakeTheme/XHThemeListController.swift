//
//  XHThemeListController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 3/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHThemeListController: XHTableViewController {
    
    var dataSource: [XHPaperDetail]?
    
    var models: [XHPaperDetail]? {
        didSet {
            guard let infos = models else {
                return
            }
            dataSource = infos
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        guard let datas = dataSource else {
            return UITableViewCell()
        }
        cell.textLabel?.text = datas[indexPath.row].name
        return cell
    }
}
