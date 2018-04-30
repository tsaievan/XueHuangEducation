//
//  XHTeachViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SDCycleScrollView

class XHTeachViewController: XHTableViewController {
    
    var dataSource: [XHCourseCatalog]?
    
    var info: (response: [XHCourseCatalog], imageArr: String?)? {
        didSet {
            guard let modelInfo = info,
                let imageUrl = modelInfo.imageArr,
                let cycle = cycleBanner else {
                    cycleBanner?.isHidden = true
                    return
            }
            dataSource = modelInfo.response
            cycle.imageURLStringsGroup = [imageUrl, imageUrl]
            tableView.reloadData()
        }
    }
    
    lazy var cycleBanner: SDCycleScrollView?  = {
        guard let cycle = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * CYCLE_BANNER_HEIGHT_WIDTH_RATIO), delegate: self, placeholderImage: nil) else {
            return nil
        }
        cycle.autoScroll = false
        cycle.showPageControl = false
        tableView.tableHeaderView = cycle
        return cycle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        tableView.register(XHNetCourseDetailCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_NETCOURSE_DETAIL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = dataSource?.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSource else {
            return 0
        }
        let sectionModel = datas[section]
        guard let count = sectionModel.simpleNetCourses?.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_NETCOURSE_DETAIL, for: indexPath)
        guard let newCell = cell as? XHNetCourseDetailCell,
        let datas = dataSource else {
            return UITableViewCell()
        }
        let sectionModel = datas[indexPath.section]
        guard let models = sectionModel.simpleNetCourses else {
            return UITableViewCell()
        }
        newCell.info = (models[indexPath.row], sectionModel.iconAddr)
        return newCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return nil
//    }
}

extension XHTeachViewController: SDCycleScrollViewDelegate {
    
}
