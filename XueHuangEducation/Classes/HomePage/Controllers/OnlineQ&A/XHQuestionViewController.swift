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
        let header = XHQuestionHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        header.xh_delegate = self
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
    
    var newInfo: (response: [XHCourseCatalog], questionList: XHQuestionList)? {
        didSet {
            guard let modelInfo = newInfo else {
                return
            }
            dataSource = modelInfo.response
            headerView.newInfo = modelInfo.questionList
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
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            ///< 当第一个cell消失的时候, popMenuView跟着消失
            headerView.dismissPopMenuView()
        }
    }
}

extension XHQuestionViewController: XHQuestionHeaderViewDelegate {
    func questionHeaderViewDidClickButtonList(sectionView: XHQuestionHeaderView, sender: UIButton) {
        guard let questionList = newInfo?.questionList,
            let catalogs = questionList.sCourseCatalogs else {
                return
        }
        let catalog = catalogs[sender.tag]
        XHProfile.getMyMobieQuestionList(withEnterType: XHQuestionEnterType.answer, courseClassId: catalog.id ?? "", success: { (catalogs, questionModel) in
            self.newInfo = (catalogs, questionModel)
        }) { (error) in
            if error.code == -1 { ///< 表示没有数据
            }else if error.code == -1009 { ///< 网络连接失败
                XHAlertHUD.showError(withStatus: "网络连接失败")
            }else { ///< 获取答疑列表失败
                XHAlertHUD.showError(withStatus: "获取我的答疑列表失败")
            }
        }
    }
}
