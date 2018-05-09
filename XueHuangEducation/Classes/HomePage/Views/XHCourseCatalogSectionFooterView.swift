//
//  XHCourseCatalogSectionFooterView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHCourseCatalogSectionFooterView: UIView {
    lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "image_homepage_logo")
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    lazy var chTitileImageView: UIImageView = {
        let ch = UIImageView()
        ch.image = UIImage(named: "image_homepage_chTitle")
        ch.contentMode = .scaleAspectFill
        return ch
    }()
    
    lazy var enTitleImageView: UIImageView = {
        let en = UIImageView()
        en.image = UIImage(named: "image_homepage_enTitle")
        en.contentMode = .scaleAspectFill
        return en
    }()
    
    lazy var sloganImageView: UIImageView = {
        let slogan = UIImageView()
        slogan.image = UIImage(named: "image_homepage_slogan")
        slogan.contentMode = .scaleAspectFill
        return slogan
    }()
    
    lazy var containView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 5
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
            make.left.equalTo(self).offset(MARGIN_GLOBAL_10)
            make.right.equalTo(self).offset(-MARGIN_GLOBAL_10)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containView).offset(MARGIN_GLOBAL_14 * 2)
            make.left.equalTo(containView).offset(MARGIN_GLOBAL_20)
        }
        
        chTitileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containView).offset(MARGIN_GLOBAL_20 + MARGIN_GLOBAL_14)
            make.width.equalTo(XHSCreen.width * 0.6)
            make.left.equalTo(logoImageView.snp.right).offset(MARGIN_GLOBAL_15)
            make.right.equalTo(containView).offset(-MARGIN_GLOBAL_20)
        }
        
        enTitleImageView.snp.makeConstraints { (make) in
            make.top.equalTo(chTitileImageView.snp.bottom).offset(MARGIN_GLOBAL_25)
            make.leading.trailing.equalTo(chTitileImageView)
        }
        
        
        
        sloganImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(logoImageView).offset(MARGIN_GLOBAL_20)
            make.trailing.equalTo(enTitleImageView).offset(-MARGIN_GLOBAL_20)
            make.top.equalTo(enTitleImageView).offset(MARGIN_GLOBAL_60)
        }
        
        containView.snp.makeConstraints { (make) in
            make.bottom.equalTo(sloganImageView).offset(MARGIN_GLOBAL_20).priority(.low)
        }
    }
}
