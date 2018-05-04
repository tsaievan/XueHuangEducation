//
//  XHThemeViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHThemeViewController: XHTableViewController {
    
    var dataSource: [XHCourseCatalog]?
    
    var mainTitle: String?
    
    var info: (response: [XHCourseCatalog], titleText: String?)? {
        didSet {
            guard let modelInfo = info else {
                return
            }
            mainTitle = modelInfo.titleText
            dataSource = modelInfo.response
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        tableView.separatorStyle = .none
        tableView.register(XHPaperDetailCell.self, forCellReuseIdentifier: CELL_IDENTIFIER_PAPER_DETAIL)
        tableView.register(XHTeachSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HEADERVIEW_IDENTIFIER_TEACH_TABLEVIEW)
        tableView.register(XHPaperSectionTitleView.self, forHeaderFooterViewReuseIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_PAPER_TABLEVIEW)
        ///< 这两句代码是使得section之间的view不再有缝隙
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
        ///< 去除分割线
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view 数据源和代理方法
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
        guard let count = sectionModel.paperLists?.count else {
            return 0
        }
        return sectionModel.isFold! ? count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_PAPER_DETAIL, for: indexPath)
        guard let newCell = cell as? XHPaperDetailCell,
            let datas = dataSource else {
                return UITableViewCell()
        }
        let sectionModel = datas[indexPath.section]
        guard let models = sectionModel.paperLists else {
            return UITableViewCell()
        }
        newCell.info = models[indexPath.row]
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
        let sectionModel = datas[section]
        if section == 0 {
            guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADER_TITLE_VIEW_IDENTIFIER_PAPER_TABLEVIEW) as? XHPaperSectionTitleView else {
                return nil
            }
            sectionView.info = (sectionModel, mainTitle)
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
        tableView.deselectRow(at: indexPath, animated: false)
        let themeListVc = XHThemeListController(style: .plain)
        navigationController?.pushViewController(themeListVc, animated: true)
        ///< 这里开始请求数据
        guard let datas = dataSource else {
            return
        }
        let sectionModel = datas[indexPath.section]
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
}
