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
    
    var dataSource: (catalogs: [XHCourseCatalog], themeList: XHThemeList?)?
    
    var info: (response: [XHCourseCatalog], imageArr: String?)? {
        didSet {
            guard let modelInfo = info,
                let imageUrl = modelInfo.imageArr,
                let cycle = cycleBanner else {
                    return
            }
            if imageUrl == "" {
                tableView.tableHeaderView = UIView(frame: .zero)
                ///< 这里需要设置一下contentInset的缩进, 不然很丑
                tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0)
            }else {
                tableView.tableHeaderView = cycle
            }
            dataSource = (modelInfo.response, nil)
            cycle.imageURLStringsGroup = [imageUrl, imageUrl]
            tableView.reloadData()
        }
    }
    
    var newInfo: (response: [XHCourseCatalog], themeList: XHThemeList)? {
        didSet {
            tableView.tableHeaderView = UIView(frame: .zero)
            ///< 这里需要设置一下contentInset的缩进, 不然很丑
            tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0)
            guard let modelInfo = newInfo else {
                return
            }
            dataSource = (modelInfo.response, modelInfo.themeList)
            tableView.reloadData()
            
        }
    }
    
    lazy var cycleBanner: SDCycleScrollView?  = {
        guard let cycle = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * CYCLE_BANNER_HEIGHT_WIDTH_RATIO), delegate: nil, placeholderImage: nil) else {
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
        tableView.register(XHSectionTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW)
        
        ///< 这两句代码是使得section之间的view不再有缝隙
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
        
        ///< 去除分割线
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view 的数据源和代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let datas = dataSource?.catalogs else {
            return 0
        }
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSource?.catalogs else {
            return 0
        }
        let sectionModel = datas[section]
        guard let count = sectionModel.netCourses?.count else {
            return 0
        }
        return sectionModel.isFold! ? count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_NETCOURSE_DETAIL, for: indexPath)
        guard let newCell = cell as? XHNetCourseDetailCell,
            let datas = dataSource?.catalogs else {
                return UITableViewCell()
        }
        let sectionModel = datas[indexPath.section]
        guard let models = sectionModel.netCourses else {
            return UITableViewCell()
        }
        newCell.info = (models[indexPath.row], sectionModel.iconAddr)
        return newCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 90
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let datas = dataSource else {
            return nil
        }
        let sectionModel = datas.catalogs[section]
        if section == 0 {
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW) as? XHSectionTitleHeaderView else {
                return nil
            }
            sectionView.info = (sectionModel, datas.themeList)
            sectionView.tapSectionClosure = {
                sectionModel.isFold = !sectionModel.isFold!
                self.tableView.reloadData()
            }
            return sectionView
            
        }else {
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW) as? XHTeachSectionHeaderView else {
                return nil
            }
            sectionView.model = sectionModel
            sectionView.tapSectionClosure = {
                sectionModel.isFold = !sectionModel.isFold!
                self.tableView.reloadData()
            }
            return sectionView
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let datas = dataSource?.catalogs else {
            return
        }
        let sectionModel = datas[indexPath.section]
        guard let models = sectionModel.netCourses,
            let courseName = models[indexPath.row].netCourseName,
            let courseId = models[indexPath.row].netCourseId else {
                return
        }
        let netVc = XHNetCourseWareController()
        netVc.navigationItem.title = courseName
        navigationController?.pushViewController(netVc, animated: true)
        XHTeach.getNetcourseware(withCourseName: courseName, courseId: courseId, success: { (response) in
            netVc.models = response
        }) { (errorReason) in
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            guard let headerView = view as? XHSectionTitleHeaderView else {
                return
            }
            headerView.dismissPopMenuView()
        }
    }
}
