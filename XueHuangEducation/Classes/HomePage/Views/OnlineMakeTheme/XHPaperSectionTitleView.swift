//
//  XHPaperSectionTitleView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHPaperSectionTitleView: UITableViewHeaderFooterView {
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_PAPAER_TYPE_BUTTON_TITLE, fontSize: FONT_SIZE_16)
        lbl.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_16)
        return lbl
    }()
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "button_paperList_more"), for: .normal)
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
    
    var info: (model: XHCourseCatalog, text: String?)?{
        didSet {
            guard let modelInfo = info else {
                return
            }
            headerView.model = modelInfo.model
            titleLabel.text = modelInfo.text
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

extension XHPaperSectionTitleView {
    fileprivate func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(seperatorView)
        contentView.addSubview(headerView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_15)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView)
            make.height.equalTo(0.5)
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(MARGIN_GLOBAL_10)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView.snp.bottom)
            make.left.right.equalTo(contentView)
            make.height.equalTo(50).priority(.low)
        }
    }
}

