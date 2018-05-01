//
//  XHCatalogListViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

///< 这里的逻辑有点多, 直接将view写在控制器里, 方便调用各个方法, 免得产生太多的胶水代码
class XHCatalogListViewController: XHBaseViewController {
    
    var teachVc: XHTeachViewController = XHTeachViewController(style: .grouped)
    
    var themeVc: XHThemeViewController = XHThemeViewController(style: .grouped)
    
    var questionVc: XHQuestionViewController = XHQuestionViewController(style: .grouped)
    
    lazy var segmentView: XHCatalogListSegmentView = {
        let s = XHCatalogListSegmentView()
        s.backgroundColor = .white
        s.xh_delegate = self
        return s
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.backgroundColor = .yellow
        sv.contentSize = CGSize(width: SCREEN_WIDTH * 3, height: 0)
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
            XHHomePage.getTeachCourseList(withCourseName: courseName, courseId: courseId, success: { (response, imageArr) in
                print("\(response)")
                let info = (response, imageArr)
                self.teachVc.info = info
                
            }, failue: { (error) in
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
            make.height.equalTo(84)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        teachVc.view.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(contentView)
            make.width.equalTo(SCREEN_WIDTH)
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
            make.width.equalTo(SCREEN_WIDTH * 3)
        }
    }
}

// MARK: - UIScrollView的代理
extension XHCatalogListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isEqual(self.scrollView) {
            let offsetX = scrollView.contentOffset.x
            if offsetX > SCREEN_WIDTH + SCREEN_WIDTH * 0.6 {
                segmentView.selectedPage = 2
            }else if offsetX > SCREEN_WIDTH * 0.6 && offsetX <= SCREEN_WIDTH + SCREEN_WIDTH * 0.6 {
                segmentView.selectedPage = 1
            }else {
                segmentView.selectedPage = 0
            }
        }
    }
}

// MARK: - XHCatalogListSegmentView的代理
extension XHCatalogListViewController: XHCatalogListSegmentViewDelegate {
    func catalogListSegmentViewDidClickSegmentButton(segmentView: XHCatalogListSegmentView, sender: XHButton) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(sender.tag) * SCREEN_WIDTH, y: 0), animated: false)
        if sender.tag == 1 {
            guard let courseModel = model,
                let courseId = courseModel.id else {
                    return
            }
            XHHomePage.getPaperList(withCourseClassId: courseId, success: { (response, string) in
                
            }, failue: { (errorReason) in
                XHAlertHUD.showError(withStatus: errorReason)
            })
        }
    }
}
