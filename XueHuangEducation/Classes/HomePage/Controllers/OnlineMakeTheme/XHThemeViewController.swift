//
//  XHThemeViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension XHNetworkError.Desription.ThemeViewController {
    ///< 获取我的讲题列表失败
    static let getPaperListFailue: String = "获取答题列表失败"
}

extension XHThemeViewController {
    
    ///< 第一个组头的高度
    private var firstSectionHeight: CGFloat { return 90.0 }
    
    ///< 其余的组头高度
    private var normalSectionHeight: CGFloat { return 50.0 }
}

class XHThemeViewController: XHTableViewController {
    
    ///< 数据源
    var dataSource: (catalogs: [XHCourseCatalog], paperList: XHPaperList?)?
    
    ///< navigationItem的title
    var mainTitle: String?
    
    ///< 主页进来时赋值的model
    var info: (response: [XHCourseCatalog], titleText: String?)? {
        didSet {
            guard let modelInfo = info else {
                return
            }
            mainTitle = modelInfo.titleText
            dataSource = (modelInfo.response, nil)
            tableView.reloadData()
        }
    }
    
    ///< 个人中心进来时赋值的model
    var newInfo: (response: [XHCourseCatalog], paperList: XHPaperList)? {
        didSet {
            guard let modelInfo = newInfo else {
                return
            }
            dataSource = (modelInfo.response, modelInfo.paperList)
            tableView.reloadData()
        }
    }

    // MARK: - 生命周期
    ///< 页面已经加载
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        tableView.separatorStyle = .none
        tableView.register(XHPaperDetailCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_PAPER_DETAIL)
        tableView.register(XHTeachSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW)
        tableView.register(XHPaperSectionTitleView.self, forHeaderFooterViewReuseIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_PAPER_TABLEVIEW)
        ///< 这两句代码是使得section之间的view不再有缝隙
        tableView.sectionFooterHeight = CGFloat.tableViewMinimumFooterHeight
        tableView.sectionHeaderHeight = CGFloat.tableViewMinimumHeaderHeight
        ///< 去除分割线
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view 数据源和代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = dataSource?.catalogs.count else {
            return noData
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas = dataSource else {
            return noData
        }
        let sectionModel = datas.catalogs[section]
        guard let count = sectionModel.paperLists?.count else {
            return noData
        }
        return sectionModel.isFold! ? count : noData
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_PAPER_DETAIL, for: indexPath)
        guard let newCell = cell as? XHPaperDetailCell,
            let datas = dataSource else {
                return UITableViewCell()
        }
        let sectionModel = datas.catalogs[indexPath.section]
        guard let models = sectionModel.paperLists else {
            return UITableViewCell()
        }
        newCell.info = models[indexPath.row]
        return newCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == firstSection {
            return firstSectionHeight
        }
        return normalSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let datas = dataSource else {
            return nil
        }
        let sectionModel = datas.catalogs[section]
        if section == firstSection {
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_PAPER_TABLEVIEW) as? XHPaperSectionTitleView else {
                return nil
            }
            sectionView.newInfo = (sectionModel, datas.paperList)
            if datas.paperList == nil {
                sectionView.sectionTitle = mainTitle
            }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let themeListVc = XHThemeListController(style: .plain)
        navigationController?.pushViewController(themeListVc, animated: true)
        ///< 这里开始请求数据
        guard let datas = dataSource else {
            return
        }
        let sectionModel = datas.catalogs[indexPath.section]
        guard let models = sectionModel.paperLists else {
            return
        }
        let info = models[indexPath.row]
        guard let paperId = info.id else {
            return
        }
        XHMobilePaper.getMobilePaperCatalog(withPaperId: paperId, success: { (response) in
            themeListVc.info = (response, info.paperName)
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if section == firstSection {
            guard let headerView = view as? XHPaperSectionTitleView else {
                return
            }
            headerView.dismissPopMenuView()
        }
    }
}

extension XHThemeViewController: XHPaperSectionTitleViewDelegate {
    func paperSectionTitleViewDidClickButtonList(sectionView: XHPaperSectionTitleView, sender: UIButton) {
        guard let paperList = newInfo?.paperList,
            let catalogs = paperList.sCourseCatalogs else {
                return
        }
        let catalog = catalogs[sender.tag]
        XHProfile.getMyMobiePaperList(withCourseClassId: catalog.id ?? String.empty, success: { (catalogs, paperModel) in
            self.newInfo = (catalogs, paperModel)
        }) { (error) in
            if error.code == XHNetworkError.Code.noData { ///< 表示没有数据
            }else if error.code == XHNetworkError.Code.connetFailue { ///< 网络连接失败
                XHAlertHUD.showError(withStatus: XHNetworkError.Desription.connectFailue)
            }else { ///< 获取列表失败
                XHAlertHUD.showError(withStatus: XHNetworkError.Desription.ThemeViewController.getPaperListFailue)
            }
        }
    }
}
