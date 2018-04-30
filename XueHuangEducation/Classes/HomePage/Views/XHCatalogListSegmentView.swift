//
//  XHCatalogListSegmentView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHCatalogListSegmentView: UIView {
    
    let horizontalScale = UIDevice.horizontalScale
    
    lazy var myTeachButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myTeach", title: "网校讲题", titleFont: FONT_SIZE_13, gap: 0)
        return btn
    }()
    
    lazy var myThemeButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myTheme", title: "在线做题", titleFont: FONT_SIZE_13, gap: 0)
        return btn
    }()
    
    lazy var myQuestionButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myQuestion", title: "在线问答", titleFont: FONT_SIZE_13, gap: 0)
        return btn
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
extension XHCatalogListSegmentView {
    fileprivate func setupUI() {
        backgroundColor = .white
        addSubview(myTeachButton)
        addSubview(myThemeButton)
        addSubview(myQuestionButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        myTeachButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_44 * horizontalScale)
            make.width.equalTo((SCREEN_WIDTH - 2 * (MARGIN_GLOBAL_44 * horizontalScale + MARGIN_GLOBAL_44 * horizontalScale)) / 3)
        }
        
        myThemeButton.snp.makeConstraints { (make) in
            make.left.equalTo(myTeachButton.snp.right).offset(MARGIN_GLOBAL_44 * horizontalScale)
            make.top.width.equalTo(myTeachButton)
        }
        
        myQuestionButton.snp.makeConstraints { (make) in
            make.left.equalTo(myThemeButton.snp.right).offset(MARGIN_GLOBAL_44 * horizontalScale)
            make.top.width.equalTo(myThemeButton)
        }
    }
}
