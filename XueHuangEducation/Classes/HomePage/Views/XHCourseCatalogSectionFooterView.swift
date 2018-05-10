//
//  XHCourseCatalogSectionFooterView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension String {
    struct CourseCatalogSectionFooterView {
        static let logoImageName = "image_homepage_logo"
        static let chTitileImageName = "image_homepage_chTitle"
        static let enTitleImageName = "image_homepage_enTitle"
        static let sloganImageName = "image_homepage_slogan"
    }
}

fileprivate let logoImageName = String.CourseCatalogSectionFooterView.logoImageName
fileprivate let chTitileImageName = String.CourseCatalogSectionFooterView.chTitileImageName
fileprivate let enTitleImageName = String.CourseCatalogSectionFooterView.enTitleImageName
fileprivate let sloganImageName = String.CourseCatalogSectionFooterView.sloganImageName

class XHCourseCatalogSectionFooterView: UIView {
    lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: logoImageName)
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    lazy var chTitileImageView: UIImageView = {
        let ch = UIImageView()
        ch.image = UIImage(named: chTitileImageName)
        ch.contentMode = .scaleAspectFill
        return ch
    }()
    
    lazy var enTitleImageView: UIImageView = {
        let en = UIImageView()
        en.image = UIImage(named: enTitleImageName)
        en.contentMode = .scaleAspectFill
        return en
    }()
    
    lazy var sloganImageView: UIImageView = {
        let slogan = UIImageView()
        slogan.image = UIImage(named: sloganImageName)
        slogan.contentMode = .scaleAspectFill
        return slogan
    }()
    
    lazy var containView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = CGFloat.commonCornerRadius
        v.layer.masksToBounds = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHCourseCatalogSectionFooterView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.Global.background
        addSubview(containView)
        containView.addSubview(logoImageView)
        containView.addSubview(chTitileImageView)
        containView.addSubview(enTitleImageView)
        containView.addSubview(sloganImageView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        containView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(XHMargin._10)
            make.right.equalTo(self).offset(-XHMargin._10)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containView).offset(XHMargin._14 * 2)
            make.left.equalTo(containView).offset(XHMargin._20)
        }
        
        chTitileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containView).offset(XHMargin._20 + XHMargin._14)
            make.width.equalTo(XHSCreen.width * 0.6)
            make.left.equalTo(logoImageView.snp.right).offset(XHMargin._15)
            make.right.equalTo(containView).offset(-XHMargin._20)
        }
        
        enTitleImageView.snp.makeConstraints { (make) in
            make.top.equalTo(chTitileImageView.snp.bottom).offset(XHMargin._25)
            make.leading.trailing.equalTo(chTitileImageView)
        }
        
        sloganImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(logoImageView).offset(XHMargin._20)
            make.trailing.equalTo(enTitleImageView).offset(-XHMargin._20)
            make.top.equalTo(enTitleImageView).offset(XHMargin._60)
        }
        
        containView.snp.makeConstraints { (make) in
            make.bottom.equalTo(sloganImageView).offset(XHMargin._20).priority(.low)
        }
    }
}
