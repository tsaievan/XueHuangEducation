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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        ///< 要先判断是否登录, 没有登录的话要先弹出登录框
        guard let _ = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY] else {
            let alertVc = UIAlertController(title: "信息", message: "您好, 请先登录系统 !", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
            ///< 弹出登录界面
            let confirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
                let loginVc = XHLoginViewController()
                let loginNav = XHNavigationController(rootViewController: loginVc)
                self.navigationController?.present(loginNav, animated: true, completion: nil)
            })
            alertVc.addAction(action)
            alertVc.addAction(confirm)
            present(alertVc, animated: true, completion: nil)
            return
        }
        
        ///< 这里要判断是否有做题的权限
        guard let datas = dataSource else {
            return
        }
        let model = datas[indexPath.row]
        guard let paperId = model.paperId,
         let paperCatalogId = model.id else {
            return
        }
        XHMobilePaper.isAllowedAnswerQuestion(forPaperId: paperId, paperCatalogId: paperCatalogId, success: { (isAllowedAnswer) in
            guard let success = isAllowedAnswer.success else {
                return
            }
            if success == true { ///< 这个是有答题权限的
                ///< 有答题权限的要弹框出来
                ///< 要校验是否有答题记录
                XHMobilePaper.hasQuestionLog(forPaperId: paperId, paperCatalogId: paperCatalogId, success: { (hasQuestionLog) in
                    if hasQuestionLog { ///< 有做题记录
                        
                    }else { ///< 没有做题记录
                        ///< 这个只弹出普通的弹框(没有做题记录)
                        ///< 开始做题, 查看解析, 我的收藏, 取消
                        let alertVc = UIAlertController(title: "信息", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
                        let start = UIAlertAction(title: "开始做题", style: UIAlertActionStyle.default, handler: { (action) in
                            let params = [
                                "paperCatalogId" : paperCatalogId,
                                "paperId" : paperId,
                                "isJj" : 0,
                                "isViewAnswer" : 0,
                                ] as [String : Any]
                            let url = XHNetwork.getWebUrl(withUrl: URL_MOBILE_PAPER_QUESTION, params: params)
                            let webVc = XHShowThemeWebController()
                            webVc.webUrl = url
                            self.navigationController?.pushViewController(webVc, animated: true)
                        })
                        let check = UIAlertAction(title: "查看解析", style: UIAlertActionStyle.default, handler: { (action) in
                            
                        })
                        let collection = UIAlertAction(title: "我的收藏", style: UIAlertActionStyle.default, handler: { (action) in
                            
                        })
                        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                        alertVc.addAction(start)
                        alertVc.addAction(check)
                        alertVc.addAction(collection)
                        alertVc.addAction(cancel)
                        self.present(alertVc, animated: true, completion: nil)
                    }
                }, failue: { (error) in
                    ///< 这个只弹出普通的弹框(没有做题记录)
                    ///< 开始做题, 查看解析, 我的收藏, 取消
                    let alertVc = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
                    let start = UIAlertAction(title: "开始做题", style: UIAlertActionStyle.default, handler: { (action) in

                    })
                    let check = UIAlertAction(title: "查看解析", style: UIAlertActionStyle.default, handler: { (action) in
                        
                    })
                    let collection = UIAlertAction(title: "我的收藏", style: UIAlertActionStyle.default, handler: { (action) in
                        
                    })
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    alertVc.addAction(start)
                    alertVc.addAction(check)
                    alertVc.addAction(collection)
                    alertVc.addAction(cancel)
                    self.present(alertVc, animated: true, completion: nil)
                })
            }else {
                let message = isAllowedAnswer.msg ?? "获取答题权限失败"
                let alertVc = UIAlertController(title: "信息", message: message, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                ///< 弹出登录界面
                let confirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
                alertVc.addAction(action)
                alertVc.addAction(confirm)
                self.present(alertVc, animated: true, completion: nil)
            }
        }) { (errorReason) in
            XHAlertHUD.showError(withStatus: errorReason)
        }
    }
}
