//
//  XHPaperListHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 4/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHPaperListHeaderView: UIView {
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "image_theme_paperList")
        v.sizeToFit()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_PAPAER_TYPE_BUTTON_TITLE, fontSize: FONT_SIZE_16)
        lbl.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_16)
        return lbl
    }()
    
    lazy var seperatorView: UIView = {
        let s = UIView()
        s.backgroundColor = COLOR_HOMEPAGE_CATALOG_SEPERATOR_COLOR
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHPaperListHeaderView {
    fileprivate func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(seperatorView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(MARGIN_GLOBAL_10)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView)
            make.bottom.equalTo(self).offset(-0.5)
            make.right.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}
