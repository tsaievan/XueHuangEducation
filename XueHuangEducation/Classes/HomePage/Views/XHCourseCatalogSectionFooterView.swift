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
        
        return logo
    }()
    
    lazy var chTitileImageView: UIImageView = {
        let ch = UIImageView()
        
        return ch
    }()
    
    lazy var enTitleImageView: UIImageView = {
        let en = UIImageView()
        
        return en
    }()
    
    lazy var sloganImageView: UIImageView = {
        let slogan = UIImageView()
        
        return slogan
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(logoImageView)
        addSubview(chTitileImageView)
        addSubview(enTitleImageView)
        addSubview(sloganImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
