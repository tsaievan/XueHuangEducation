//
//  XHCourseCatalogSectionHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHCourseCatalogSectionHeaderView: UIView {
    
    var models: [XHCourseCatalog]? {
        didSet {
            guard let arrays = models,
            let model = arrays.first,
            let title = model.customName else {
                titleLabel.text = "建工类"
                return
            }
            titleLabel.text = title
        }
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "image_homepage_catalog"))
        return iv
    }()
    
    lazy var titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.textColor = COLOR_GLOBAL_BLUE
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.sizeToFit()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHCourseCatalogSectionHeaderView {
    fileprivate func setupUI() {
        backgroundColor = COLOR_HOMEPAGE_BACKGROUND
        addSubview(imageView)
        addSubview(titleLabel)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(imageView.snp.right).offset(5)
        }
    }
}
