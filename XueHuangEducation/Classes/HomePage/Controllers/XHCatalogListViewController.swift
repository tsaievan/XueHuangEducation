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
    
    var teachVc: XHTeachViewController = XHTeachViewController()
    
    var themeVc: XHThemeViewController = XHThemeViewController()
    
    var questionVc: XHQuestionViewController = XHQuestionViewController()
    
    lazy var segmentView: XHCatalogListSegmentView = {
        let s = XHCatalogListSegmentView()
        s.backgroundColor = .white
        return s
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
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

extension XHCatalogListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
