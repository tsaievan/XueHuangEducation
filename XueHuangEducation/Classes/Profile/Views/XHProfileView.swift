//
//  XHProfileView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 29/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHProfileView: UIView {
    
    lazy var backgroundImageView: UIImageView = {
        let bv = UIImageView()
        bv.image = UIImage(named: "")
        return bv
    }()
    
    lazy var iconView: UIView = {
        let icon = UIView()
        
        return icon
    }()
    
    lazy var iconImageView: UIView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "")
        return iconImage
    }()
    
    lazy var welcomeLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: nil, fontSize: 17)
        return lbl
    }()
    
    lazy var buttonContainerView: UIView = {
        let buttonContainer = UIView()
        return buttonContainer
    }()
    
    lazy var logoView: XHCourseCatalogSectionFooterView = {
        let logo = XHCourseCatalogSectionFooterView()
        return logo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHProfileView {
    fileprivate func setupUI() {
        addSubview(backgroundImageView)
        addSubview(iconView)
        addSubview(iconImageView)
        addSubview(welcomeLabel)
        addSubview(buttonContainerView)
        addSubview(logoView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        
    }
}
