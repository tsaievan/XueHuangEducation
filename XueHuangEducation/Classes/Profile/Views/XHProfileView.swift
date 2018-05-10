//
//  XHProfileView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 29/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

protocol XHProfileViewDelegate: NSObjectProtocol {
    func profileViewdidClickThreeButtons(profileView: XHProfileView, sender: XHButton)
}

class XHProfileView: UIView {
    
    var xh_delegate: XHProfileViewDelegate?

    let horizontalScale = UIDevice.horizontalScale
    
    let profileInfo: XHLoginMember? = XHPreferences[.USERDEFAULT_ACCOUNT_LOGIN_RESULT_KEY]
    
    lazy var backgroundImageView: UIImageView = {
        let bv = UIImageView()
        bv.image = UIImage(named: "image_profile_background")
        bv.contentMode = .scaleAspectFill
        return bv
    }()
    
    lazy var myTeachButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myTeach", title: "我的讲题", titleFont: CGFloat.FontSize._14)
        btn.addTarget(self, action: #selector(didClickProfileViewThreeButtonsAction), for: .touchUpInside)
        btn.tag = XHButtonType.teach.rawValue
        return btn
    }()
    
    lazy var myThemeButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myTheme", title: "我的题库", titleFont: CGFloat.FontSize._14)
        btn.addTarget(self, action: #selector(didClickProfileViewThreeButtonsAction), for: .touchUpInside)
        btn.tag = XHButtonType.theme.rawValue
        return btn
    }()
    
    lazy var myQuestionButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myQuestion", title: "我的答疑", titleFont: CGFloat.FontSize._14)
        btn.addTarget(self, action: #selector(didClickProfileViewThreeButtonsAction), for: .touchUpInside)
        btn.tag = XHButtonType.answer.rawValue
        return btn
    }()
    
    lazy var bannerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var iconView: UIView = {
        let icon = UIView()
        icon.layer.cornerRadius = 5
        icon.layer.masksToBounds = true
        icon.backgroundColor = .white
        return icon
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "image_profile_default")
        iconImage.contentMode = .scaleAspectFit
        iconImage.layer.cornerRadius = 5
        iconImage.layer.masksToBounds = true
        return iconImage
    }()
    
    lazy var welcomeLabel: UILabel = {
        var text: String = ""
        if let info = profileInfo?.accounts {
            text = "您好, \(info) !"
        }else {
            text = "您好 !"
        }
        let lbl = UILabel(text: text, textColor: COLOR_PROFILE_BUTTON_TITLE_COLOR)
        lbl.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._16)
        return lbl
    }()
    
    lazy var buttonContainerView: UIView = {
        let buttonContainer = UIView()
        buttonContainer.backgroundColor = UIColor.Global.background
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
        backgroundColor = UIColor.Global.background
        addSubview(backgroundImageView)
        addSubview(bannerView)
        addSubview(iconView)
        addSubview(iconImageView)
        addSubview(welcomeLabel)
        insertSubview(buttonContainerView, belowSubview: iconView)
        addSubview(myTeachButton)
        addSubview(myThemeButton)
        addSubview(myQuestionButton)
        addSubview(logoView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(XHSCreen.width * 0.20)
        }
        
        bannerView.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundImageView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(XHMargin._44)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(XHMargin._10)
            make.centerY.equalTo(bannerView).offset(-XHMargin._5)
            make.width.height.equalTo(75)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(iconView).offset(4)
            make.bottom.right.equalTo(iconView).offset(-4)
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(XHMargin._10)
            make.centerY.equalTo(bannerView)
        }
        
        buttonContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(bannerView.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(myTeachButton).offset(XHMargin._30).priority(.low)
        }
        
        myTeachButton.snp.makeConstraints { (make) in
            make.top.equalTo(buttonContainerView).offset(XHMargin._30)
            make.left.equalTo(buttonContainerView).offset(XHMargin._30 * horizontalScale)
            make.width.equalTo((XHSCreen.width - 2 * (XHMargin._30 * horizontalScale + XHMargin._44 * horizontalScale)) / 3)
        }
        
        myThemeButton.snp.makeConstraints { (make) in
            make.left.equalTo(myTeachButton.snp.right).offset(XHMargin._44 * horizontalScale)
            make.top.width.equalTo(myTeachButton)
        }
        
        myQuestionButton.snp.makeConstraints { (make) in
            make.left.equalTo(myThemeButton.snp.right).offset(XHMargin._44 * horizontalScale)
            make.top.width.equalTo(myThemeButton)
        }
        
        logoView.snp.makeConstraints { (make) in
            make.top.equalTo(buttonContainerView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(200)
        }
    }
}

// MARK: - 按钮的点击事件
extension XHProfileView {
    @objc
    fileprivate func didClickProfileViewThreeButtonsAction(sender: XHButton) {
        ///< 我的界面的三个按钮的点击事件
        ///< 通过代理将事件传递出去
        xh_delegate?.profileViewdidClickThreeButtons(profileView: self, sender: sender)
    }
}
