//
//  XHAboutLogoView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 20/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension String {
    struct AboutLogoView {
        static let logoImageName = "image_homepage_logo"
        static let chTitileImageName = "image_homepage_chTitle"
        static let enTitleImageName = "image_homepage_enTitle"
    }
}

fileprivate let logoImageName = String.AboutLogoView.logoImageName
fileprivate let chTitileImageName = String.AboutLogoView.chTitileImageName
fileprivate let enTitleImageName = String.AboutLogoView.enTitleImageName

class XHAboutLogoView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHAboutLogoView {
    fileprivate func setupUI() {
        addSubview(logoImageView)
        addSubview(chTitileImageView)
        addSubview(enTitleImageView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(XHMargin._14 * 2)
            make.left.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        chTitileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(XHMargin._25)
            make.width.equalTo(100)
            make.left.equalTo(logoImageView.snp.right).offset(XHMargin._30)
            make.right.equalTo(self).offset(-XHMargin._20)
        }
        
        enTitleImageView.snp.makeConstraints { (make) in
            make.top.equalTo(chTitileImageView.snp.bottom).offset(XHMargin._10)
            make.leading.trailing.equalTo(chTitileImageView)
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(enTitleImageView).priority(.low)
        }
    }
}

