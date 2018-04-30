//
//  XHNetCourseDetailCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHNetCourseDetailCell: UITableViewCell {
    
    
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: nil, fontSize: 13)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var listenButton: UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHNetCourseDetailCell {
    fileprivate func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(listenButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.bottom.equalTo(contentView).offset(-MARGIN_GLOBAL_10)
            make.width.equalTo(100)
        }
        
        listenButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_10)
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView).offset(MARGIN_GLOBAL_10)
            make.right.equalTo(listenButton.snp.left).offset(-MARGIN_GLOBAL_10)
        }
    }
}
