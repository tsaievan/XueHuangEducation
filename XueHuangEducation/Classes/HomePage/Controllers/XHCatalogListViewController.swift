//
//  XHCatalogListViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import pop

/// 按钮类型
///
/// - teach: 讲题按钮
/// - theme: 做题按钮
/// - answer: 问答按钮
enum XHButtonType: Int {
    case teach = 0
    case theme = 1
    case answer = 2
}

extension CGSize {
    struct CatalogListViewController {
        static let scrollViewContentSize = CGSize(width: XHSCreen.width * 3, height: 0)
    }
}

extension String {
    struct CatalogListViewController {
        struct Title {
            static let teach = "网校讲题"
            static let theme = "考卷列表"
            static let answer = "在线问答"
        }
    }
}

extension XHRatio.W_H_R.CatalogListViewController {
    static let scrollCriticalRatio: CGFloat = 0.6
}

private let scrollCriticalRatio = XHRatio.W_H_R.CatalogListViewController.scrollCriticalRatio

private let tripleScreensWidth = XHSCreen.width * 3.0

private let segmentViewHeight = 84

///< 这里的逻辑有点多, 直接将view写在控制器里, 方便调用各个方法, 免得产生太多的胶水代码
class XHCatalogListViewController: XHBaseViewController {
    
    var teachVc: XHTeachViewController = XHTeachViewController(style: .grouped)
    
    var themeVc: XHThemeViewController = XHThemeViewController(style: .grouped)
    
    var questionVc: XHQuestionViewController = XHQuestionViewController(style: .grouped)
    
    // MARK: - 懒加载
    lazy var segmentView: XHCatalogListSegmentView = {
        let s = XHCatalogListSegmentView()
        s.backgroundColor = .white
        s.xh_delegate = self
        return s
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.backgroundColor = .white
        sv.contentSize = CGSize.CatalogListViewController.scrollViewContentSize
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.bounces = false
        sv.isPagingEnabled = true
        sv.addSubview(contentView)
        return sv
    }()
    
    lazy var contentView: UIView = {
        let cv = UIView()
        cv.addSubview(teachVc.view)
        cv.addSubview(themeVc.view)
        cv.addSubview(questionVc.view)
        return cv
    }()
    
    var model: XHCourseCatalog? {
        didSet {
            guard let courseModel = model,
                let courseName = courseModel.courseClassName,
                let courseId = courseModel.id else {
                return
            }
            navigationItem.title = courseName + String.point + String.CatalogListViewController.Title.teach
            XHHomePage.getTeachCourseList(withCourseName: courseName, courseId: courseId, success: { (response, imageArr) in
                XHGlobalLoading.stopLoading()
                let info = (response, imageArr)
                self.teachVc.info = info
            }, failue: { (error) in
                XHGlobalLoading.stopLoading()
                XHAlertHUD.showError(withStatus: error)
            })
        }
    }
    
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(teachVc)
        addChildViewController(themeVc)
        addChildViewController(questionVc)
        setupUI()
    }

}

// MARK: - 设置UI
extension XHCatalogListViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .white
        view.addSubview(segmentView)
        view.addSubview(scrollView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
            make.left.right.equalTo(view)
            make.height.equalTo(segmentViewHeight)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        teachVc.view.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(contentView)
            make.width.equalTo(XHSCreen.width)
        }
        
        themeVc.view.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(teachVc.view)
            make.left.equalTo(teachVc.view.snp.right)
        }
        
        questionVc.view.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(themeVc.view)
            make.left.equalTo(themeVc.view.snp.right)
        }
        
        ///< 上下锁定, 左右对齐
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.equalTo(view)
            make.left.right.equalTo(scrollView)
            make.width.equalTo(tripleScreensWidth)
        }
    }
}

// MARK: - UIScrollView的代理
extension XHCatalogListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isEqual(self.scrollView) {
            let offsetX = scrollView.contentOffset.x
            if offsetX > XHSCreen.width + XHSCreen.width * scrollCriticalRatio {
                segmentView.selectedPage = XHButtonType.answer.rawValue
            }else if offsetX > XHSCreen.width * scrollCriticalRatio && offsetX <= XHSCreen.width + XHSCreen.width * scrollCriticalRatio {
                segmentView.selectedPage = XHButtonType.theme.rawValue
            }else {
                segmentView.selectedPage = XHButtonType.teach.rawValue
            }
        }
    }
}

// MARK: - XHCatalogListSegmentView的代理
extension XHCatalogListViewController: XHCatalogListSegmentViewDelegate {
    func catalogListSegmentViewDidClickSegmentButton(segmentView: XHCatalogListSegmentView, sender: XHButton) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(sender.tag) * XHSCreen.width, y: CGPoint.zero.y), animated: false)
        guard let courseModel = model,
            let courseId = courseModel.id,
        let courseName = courseModel.courseClassName else {
                return
        }
        if sender.tag == XHButtonType.teach.rawValue { ///< 点击的是网校讲题的按钮
            navigationItem.title = (model?.courseClassName ?? String.empty) + String.point + String.CatalogListViewController.Title.teach
        }
        
        if sender.tag == XHButtonType.theme.rawValue { ///< 点击的是在线做题的按钮
            navigationItem.title = String.CatalogListViewController.Title.theme
            XHGlobalLoading.startLoading()
            XHHomePage.getPaperList(withCourseClassId: courseId, success: { (response, title) in
                XHGlobalLoading.stopLoading()
                self.themeVc.info = (response, title)
            }, failue: { (errorReason) in
                XHGlobalLoading.stopLoading()
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
        
        if sender.tag == XHButtonType.answer.rawValue { ///< 点击的是在线问答的按钮
            navigationItem.title = String.CatalogListViewController.Title.answer
            XHGlobalLoading.startLoading()
            XHHomePage.getQuestionList(withEnterType: XHQuestionEnterType.answer, courseName: courseName, courseId: courseId, success: { (response, title) in
                XHGlobalLoading.stopLoading()
                self.questionVc.info = (response, title)
            }, failue: { (errorReason) in
                XHGlobalLoading.stopLoading()
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
    }
}
