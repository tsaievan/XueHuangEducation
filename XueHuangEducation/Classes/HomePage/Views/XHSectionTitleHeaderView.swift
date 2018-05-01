//
//  XHSectionTitleHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHSectionTitleHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "catalogList_listen_small_button"), for: .normal)
        btn.setTitle("讲题列表", for: .normal)
        btn.setTitleColor(COLOR_GLOBAL_DARK_GRAY, for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = COLOR_CLOBAL_LIGHT_GRAY
        return v
    }()
    
    lazy var headerView: XHTeachSectionHeaderView = {
        let header = XHTeachSectionHeaderView()
        return header
    }()
    
    var model: XHCourseCatalog? {
        didSet {
            headerView.model = model
        }
    }
    
    var tapSectionClosure: XHTapTeachSectionHeaderView? {
        didSet {
            headerView.tapSectionClosure = tapSectionClosure
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHSectionTitleHeaderView {
    fileprivate func setupUI() {
        contentView.addSubview(titleButton)
        contentView.addSubview(seperatorView)
        contentView.addSubview(headerView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView)
            make.height.equalTo(0.5)
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(titleButton.snp.bottom).offset(MARGIN_GLOBAL_10)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView.snp.bottom).offset(MARGIN_GLOBAL_5)
            make.left.right.equalTo(contentView)
            make.height.equalTo(50)
        }
    }
}
