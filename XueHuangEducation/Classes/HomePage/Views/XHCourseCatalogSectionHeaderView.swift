//
//  XHCourseCatalogSectionHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIColor {
    struct CourseCatalogSectionHeaderView {
        static let seperator = UIColor(hexColor: "#EEEEEE")
    }
}

extension String {
    struct CourseCatalogSectionHeaderView {
        static let titleLabel = "建工类"
        static let imageViewImageName = "image_homepage_catalog"
    }
}

extension CGFloat {
    struct CourseCatalogSectionHeaderView {
        struct Height {
            static let seperatorView = 1.5
        }
    }
}

fileprivate let seperatorViewHeight = CGFloat.CourseCatalogSectionHeaderView.Height.seperatorView
fileprivate let titleLabelText = String.CourseCatalogSectionHeaderView.titleLabel

class XHCourseCatalogSectionHeaderView: UIView {
    
    var models: [XHCourseCatalog]? {
        didSet {
            guard let arrays = models,
            let model = arrays.first,
            let title = model.customName else {
                titleLabel.text = titleLabelText
                return
            }
            titleLabel.text = title
        }
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: String.CourseCatalogSectionHeaderView.imageViewImageName))
        return iv
    }()
    
    lazy var titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.Global.skyBlue
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._17)
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var seperatorView: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor.CourseCatalogSectionHeaderView.seperator
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

extension XHCourseCatalogSectionHeaderView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.Global.background
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(seperatorView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(XHMargin._15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(imageView.snp.right).offset(XHMargin._5)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(XHMargin._15)
            make.right.equalTo(self).offset(-XHMargin._15)
            make.height.equalTo(seperatorViewHeight)
            make.bottom.equalTo(self)
        }
    }
}
