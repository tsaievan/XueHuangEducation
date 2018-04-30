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
    
    lazy var segmentView: XHCatalogListSegmentView = {
        let s = XHCatalogListSegmentView()
        s.backgroundColor = .cyan
        return s
    }()
    
    
    ///< 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - 设置UI
extension XHCatalogListViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .white
        view.addSubview(segmentView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(TOP_EDGE_AJUSTED)
            make.left.right.equalTo(view)
            make.height.equalTo(84)
        }
    }
}
