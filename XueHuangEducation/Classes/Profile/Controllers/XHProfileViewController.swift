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
        
        if sender.tag == XHButtonType.teach.rawValue { ///< 点击我的讲题按钮
            ///< 先弹出讲题列表控制器, 这个地方可以复用
            let teachVc = XHTeachViewController(style: .grouped)
            teachVc.navigationItem.title = "网校讲题"
            teachVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(teachVc, animated: true)
            ///< 调用获取个人讲题列表的接口
            XHProfile.getMyMobileNetCourse(withCourseClassId: "", success: { (catalogs, themeModel) in
                teachVc.newInfo = (catalogs, themeModel)
            }) { (error) in
                if error.code == -1 { ///< 表示没有数据
                    let alertVc = UIAlertController(title: "信息", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    let back = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: { (action) in
                        teachVc.navigationController?.popViewController(animated: true)
                    })
                    alertVc.addAction(cancel)
                    alertVc.addAction(back)
                    teachVc.present(alertVc, animated: true, completion: nil)
                }else if error.code == -1009 { ///< 网络连接失败
                    XHAlertHUD.showError(withStatus: "网络连接失败")
                }else { ///< 获取列表失败
                    XHAlertHUD.showError(withStatus: "获取讲题列表失败")
                }
            }
        }
        
        if sender.tag == XHButtonType.theme.rawValue { ///< 点击答题列表按钮
            ///< 先弹出题库列表控制器, 这个地方可以复用
            let themeVc = XHThemeViewController(style: .grouped)
            themeVc.navigationItem.title = "考卷列表"
            themeVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(themeVc, animated: true)
            ///< 调用获取题库列表的接口
            XHProfile.getMyMobiePaperList(withCourseClassId: "", success: { (catalogs, paperList) in
                themeVc.newInfo = (catalogs, paperList)
            }, failue: { (error) in
                if error.code == -1 { ///< 表示没有数据
                    let alertVc = UIAlertController(title: "信息", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    let back = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: { (action) in
                        themeVc.navigationController?.popViewController(animated: true)
                    })
                    alertVc.addAction(cancel)
                    alertVc.addAction(back)
                    themeVc.present(alertVc, animated: true, completion: nil)
                }else if error.code == -1009 { ///< 网络连接失败
                    XHAlertHUD.showError(withStatus: "网络连接失败")
                }else { ///< 获取列表失败
                    XHAlertHUD.showError(withStatus: "获取考卷列表失败")
                }
            })
        }
        
        if sender.tag == XHButtonType.answer.rawValue { ///< 点击我的问答按钮
            let questionVc = XHQuestionViewController(style: .grouped)
            questionVc.navigationItem.title = "答疑列表"
            questionVc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(questionVc, animated: true)
            ///< 调用我的问答列表接口
            XHProfile.getMyMobieQuestionList(withEnterType: XHQuestionEnterType.answer, courseClassId: "", success: { (response, questionList) in
                questionVc.newInfo = (response, questionList)
            }, failue: { (error) in
                if error.code == -1 { ///< 表示没有数据
                    let alertVc = UIAlertController(title: "信息", message: "暂无答疑列表相关数据", preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: nil)
                    let back = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: { (action) in
                        questionVc.navigationController?.popViewController(animated: true)
                    })
                    alertVc.addAction(cancel)
                    alertVc.addAction(back)
                    questionVc.present(alertVc, animated: true, completion: nil)
                }else if error.code == -1009 { ///< 网络连接失败
                    XHAlertHUD.showError(withStatus: "网络连接失败")
                }else { ///< 获取答疑列表失败
                    XHAlertHUD.showError(withStatus: "获取答疑列表失败")
                }
            })
        }
    }
}
