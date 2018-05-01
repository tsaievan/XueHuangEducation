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
        
        tableView.register(XHNetCourseDetailCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_NETCOURSE_DETAIL)
        tableView.register(XHTeachSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW)
        
        ///< 这两句代码是使得section之间的view不再有缝隙
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
        
        ///< 去除分割线
        tableView.tableFooterView = UIView()
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
        return sectionModel.isFold! ? count : 0
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let datas = dataSource else {
            return nil
        }
        let sectionModel = datas[section]
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW) as? XHTeachSectionHeaderView else {
            return nil
        }
        sectionView.model = sectionModel
        sectionView.tapSectionClosure = {
            sectionModel.isFold = !sectionModel.isFold!
            self.tableView.reloadSections(IndexSet(integer: section), with: UITableViewRowAnimation.automatic)
        }
        return sectionView
    }
}

extension XHTeachViewController: SDCycleScrollViewDelegate {
    
}
