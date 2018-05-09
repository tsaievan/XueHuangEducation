//
//  XHTeachViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SDCycleScrollView

///< tableView的顶部缩进 -> 30
private let K_TABLEVIEW_EDGE_INSET_TOP: CGFloat = -30

///< 获取我的讲题列表失败
extension XHNetworkError.Desription {
    static let getTeachListFailue: String = "获取讲题列表失败"
}

class XHTeachViewController: XHTableViewController {
    
    ///< 第一个section
    private var firstSection: Int { return 0 }

    ///< 没数据返回0组或者0行
    private var noData: Int { return 0 }
    
    ///< cell的高度
    private var cellHeight: CGFloat { return 80.0 }
    
    ///< 第一个组头的高度
    private var firstSectionHeight: CGFloat { return 90.0 }
    
    ///< 其余的组头高度
    private var normalSectionHeight: CGFloat { return 50.0 }

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
                tableView.contentInset = UIEdgeInsetsMake(K_TABLEVIEW_EDGE_INSET_TOP, GLOBAL_ZERO, GLOBAL_ZERO, GLOBAL_ZERO)
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
            tableView.contentInset = UIEdgeInsetsMake(K_TABLEVIEW_EDGE_INSET_TOP, GLOBAL_ZERO, GLOBAL_ZERO, GLOBAL_ZERO)
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
        guard let cycle = SDCycleScrollView(frame: CGRect(x: GLOBAL_ZERO, y: GLOBAL_ZERO, width: XHSCreen.width, height: XHSCreen.width * CYCLE_BANNER_HEIGHT_WIDTH_RATIO), delegate: nil, placeholderImage: nil) else {
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
        tableView.register(XHNetCourseDetailCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_NETCOURSE_DETAIL)
        tableView.register(XHTeachSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW)
        tableView.register(XHSectionTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW)
        
        ///< 这两句代码是使得section之间的view不再有缝隙
        tableView.sectionFooterHeight = TABLEVIEW_MINIMUM_FOOTER_HEIGHT
        tableView.sectionHeaderHeight = TABLEVIEW_MINIMUM_HEADER_HEIGHT
        
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
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_TEACH_TABLEVIEW) as? XHSectionTitleHeaderView else {
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
        let netVc = XHNetCourseWareController()
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
                XHAlertHUD.showError(withStatus: XHNetworkError.Desription.getTeachListFailue)
            }
        }
    }
}
