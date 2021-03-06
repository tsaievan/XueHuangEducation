//
//  XHTeachViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SDCycleScrollView

extension UIEdgeInsets {
    struct TeachViewController {
        ///< tableView的缩进
        static let tableView = UIEdgeInsetsMake(-30, 0, 0, 0)
    }
}

extension CGRect {
    struct TeachViewController {
        ///< 轮播图的frame
        static let cycle = CGRect(x: 0, y: 0, width: XHSCreen.width, height: XHSCreen.width * XHRatio.W_H_R.TeachViewController.cycle)
    }
}

extension XHRatio.W_H_R.TeachViewController {
    ///< 轮播图的宽高比
    static let cycle: CGFloat = 0.35
}

extension XHNetworkError.Desription.TeachViewController {
    ///< 获取我的讲题列表失败
    static let getTeachListFailue: String = "获取讲题列表失败"
}

extension XHCellReuseIdentifier.TeachViewController {
    static let netCourseDetail = "CELL_IDENTIFIER_NETCOURSE_DETAIL"
}

extension XHHeaderReuseIdentifier.TeachViewController {
    static let header = "HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW"
    static let titleHeader = "HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW"
}


// MARK: - 存放一些计算属性
extension XHTeachViewController {
    
    ///< 第一个组头的高度
    private var firstSectionHeight: CGFloat { return 90.0 }
    
    ///< 其余的组头高度
    private var normalSectionHeight: CGFloat { return 50.0 }
}

class XHTeachViewController: XHTableViewController {
    
    ///< tableView的数据源
    var dataSource: (catalogs: [XHCourseCatalog], themeList: XHThemeList?)?
    
    ///< 从首页跳转过来的数据赋值
    var info: (response: [XHCourseCatalog], imageArr: String?)? {
        didSet {
            guard let modelInfo = info,
                let imageUrl = modelInfo.imageArr,
                let cycle = cycleBanner else {
                    return
            }
            if imageUrl == String.empty {
                tableView.tableHeaderView = UIView(frame: .zero)
                ///< 这里需要设置一下contentInset的缩进, 不然很丑
                tableView.contentInset = UIEdgeInsets.TeachViewController.tableView
            }else {
                tableView.tableHeaderView = cycle
            }
            dataSource = (modelInfo.response, nil)
            cycle.imageURLStringsGroup = [imageUrl, imageUrl]
            tableView.reloadData()
        }
    }
    
    ///< 从个人中心跳转过来的数据赋值
    var newInfo: (response: [XHCourseCatalog], themeList: XHThemeList)? {
        didSet {
            tableView.tableHeaderView = UIView(frame: .zero)
            ///< 这里需要设置一下contentInset的缩进, 不然很丑
            tableView.contentInset = UIEdgeInsets.TeachViewController.tableView
            guard let modelInfo = newInfo else {
                return
            }
            dataSource = (modelInfo.response, modelInfo.themeList)
            tableView.reloadData()
        }
    }
    
    // MARK: - 懒加载
    ///< 轮播图(目前只有一张图)
    lazy var cycleBanner: SDCycleScrollView?  = {
        guard let cycle = SDCycleScrollView(frame: CGRect.TeachViewController.cycle, delegate: nil, placeholderImage: nil) else {
            return nil
        }
        cycle.autoScroll = false
        cycle.showPageControl = false
        tableView.tableHeaderView = cycle
        return cycle
    }()
    
    // MARK: - 生命周期
    ///< view已经被加载
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(XHNetCourseDetailCell.self, forCellReuseIdentifier: XHCellReuseIdentifier.TeachViewController.netCourseDetail)
        tableView.register(XHTeachSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: XHHeaderReuseIdentifier.TeachViewController.header)
        tableView.register(XHSectionTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: XHHeaderReuseIdentifier.TeachViewController.titleHeader)
        
        ///< 这两句代码是使得section之间的view不再有缝隙
        tableView.sectionFooterHeight = CGFloat.tableViewMinimumFooterHeight
        tableView.sectionHeaderHeight = CGFloat.tableViewMinimumHeaderHeight
        
        ///< 去除分割线
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Table view 的数据源和代理方法
extension XHTeachViewController {
    
    ///< 返回组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let datas = dataSource?.catalogs else {
            return noData
        }
        return datas.count
    }
    
    ///< 返回行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSource?.catalogs else {
            return noData
        }
        let sectionModel = datas[section]
        guard let count = sectionModel.netCourses?.count else {
            return noData
        }
        return sectionModel.isFold! ? count : noData
    }
    
    ///< 返回cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XHCellReuseIdentifier.TeachViewController.netCourseDetail, for: indexPath)
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
    
    ///< 返回cell的高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    ///< 返回组头View
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let datas = dataSource else {
            return nil
        }
        let sectionModel = datas.catalogs[section]
        if section == firstSection {
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: XHHeaderReuseIdentifier.TeachViewController.titleHeader) as? XHSectionTitleHeaderView else {
                return nil
            }
            sectionView.info = (sectionModel, datas.themeList)
            sectionView.tapSectionClosure = {
                sectionModel.isFold = !sectionModel.isFold!
                self.tableView.reloadData()
            }
            sectionView.xh_delegate = self
            return sectionView
            
        }else {
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: XHHeaderReuseIdentifier.TeachViewController.header) as? XHTeachSectionHeaderView else {
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
    
    ///< 返回组头的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == firstSection {
            return firstSectionHeight
        }
        return normalSectionHeight
    }
    
    ///< 选中cell
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
        let netVc = XHNetCourseWareController(style: .grouped)
        netVc.navigationItem.title = courseName
        navigationController?.pushViewController(netVc, animated: true)
        XHTeach.getNetcourseware(withCourseName: courseName, courseId: courseId, success: { (response) in
            netVc.models = response
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
    
    ///< 即将结束显示某组组头View
    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if section == firstSection {
            guard let headerView = view as? XHSectionTitleHeaderView else {
                return
            }
            headerView.dismissPopMenuView()
        }
    }
}

// MARK: - sectionTitleHeaderView的代理方法
extension XHTeachViewController: XHSectionTitleHeaderViewDelegate {
    func sectionTitleHeaderViewDidClickButtonList(headerView: XHSectionTitleHeaderView, sender: UIButton) {
        guard let themeList = newInfo?.themeList,
            let catalogs = themeList.sCourseCatalogs else {
                return
        }
        let catalog = catalogs[sender.tag]
        XHProfile.getMyMobileNetCourse(withCourseClassId: catalog.id ?? String.empty, success: { (catalogs, themeModel) in
            self.newInfo = (catalogs, themeModel)
        }) { (error) in
            if error.code == XHNetworkError.Code.noData { ///< 表示没有数据
            }else if error.code == XHNetworkError.Code.connetFailue { ///< 网络连接失败
                XHAlertHUD.showError(withStatus: XHNetworkError.Desription.connectFailue)
            }else { ///< 获取列表失败
                XHAlertHUD.showError(withStatus: XHNetworkError.Desription.TeachViewController.getTeachListFailue)
            }
        }
    }
}

extension XHTeachViewController {
    @objc
    override func router(withEventName eventName: String, userInfo: [String : Any]) {
        guard let cell = userInfo[CELL_FOR_NETCOURSE_DETAIL_CELL_LISTEN_BUTTON] as? XHNetCourseDetailCell,
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        guard let datas = dataSource?.catalogs else {
            return
        }
        let sectionModel = datas[indexPath.section]
        guard let models = sectionModel.netCourses,
            let courseName = models[indexPath.row].netCourseName,
            let courseId = models[indexPath.row].netCourseId else {
                return
        }
        let netVc = XHNetCourseWareController(style: .grouped)
        netVc.navigationItem.title = courseName
        navigationController?.pushViewController(netVc, animated: true)
        XHTeach.getNetcourseware(withCourseName: courseName, courseId: courseId, success: { (response) in
            netVc.models = response
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
}
