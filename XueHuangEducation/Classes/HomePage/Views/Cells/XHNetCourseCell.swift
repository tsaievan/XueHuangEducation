//
//  XHNetCourseCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHNetCourseCell: UITableViewCell {
    
    lazy var tipView: UIView = {
        let t = UIView()
        t.backgroundColor = COLOR_GLOBAL_BLUE
        return t
    }()
    
    lazy var tipLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_HOMEPAGE_TIP_LABEL_COLOR, fontSize: FONT_SIZE_16)
        return lbl
    }()
    
    var catalogs: [XHCourseCatalog]? {
        didSet {
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHNetCourseCell {
    fileprivate func setupUI() {
        contentView.backgroundColor = COLOR_HOMEPAGE_BACKGROUND
        contentView.addSubview(tipView)
        contentView.addSubview(tipLabel)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        tipView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
            make.width.equalTo(20)
            make.height.equalTo(40)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipView)
            make.left.equalTo(tipView.snp.right).offset(5)
        }
    }
}
