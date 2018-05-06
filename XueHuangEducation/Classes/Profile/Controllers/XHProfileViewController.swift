//
//  XHProfileViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 11/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHProfileViewController: XHBaseViewController {
    
    lazy var profileView: XHProfileView = {
        let pv = XHProfileView()
        pv.xh_delegate = self
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - 设置UI
extension XHProfileViewController {
    fileprivate func setupUI() {
        navigationItem.title = "个人中心"
        view.addSubview(profileView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

// MARK: - profileView的代理
extension XHProfileViewController: XHProfileViewDelegate {
    func profileViewdidClickThreeButtons(profileView: XHProfileView, sender: XHButton) {
        if sender.tag == XHButtonType.teach.rawValue {
            ///< 先弹出讲题列表控制器, 这个地方可以复用
            let teachVc = XHTeachViewController(style: .grouped)
            teachVc.navigationItem.title = "网校讲题"
            teachVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(teachVc, animated: true)
            ///< 调用获取个人讲题列表的接口
            XHProfile.getMyMobileNetCourse(withCourseClassId: "", success: { (catalogs, themeModel) in
                teachVc.newInfo = (catalogs, themeModel)
            }) { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            }
        }
        
        if sender.tag == XHButtonType.theme.rawValue {
            ///< 先弹出题库列表控制器, 这个地方可以复用
            let themeVc = XHThemeViewController(style: .grouped)
            themeVc.navigationItem.title = "考卷列表"
            themeVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(themeVc, animated: true)
            ///< 调用获取题库列表的接口
            XHProfile.getMyMobiePaperList(withCourseClassId: "", success: { (catalogs, paperList) in
                themeVc.newInfo = (catalogs, paperList)
            }, failue: { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
        
        if sender.tag == XHButtonType.answer.rawValue {
            
        }
    }
}
