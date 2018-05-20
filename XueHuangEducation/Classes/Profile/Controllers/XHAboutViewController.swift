//
//  XHAboutViewController.swift
//  XueHuangEducation
//
//  Created by tsaievan on 19/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHAboutViewController: XHBaseViewController {
    
    lazy var logoView: XHAboutLogoView = {
        let logo = XHAboutLogoView()
        return logo
    }()
    
    lazy var qqButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "qq_buttonImage_about"), for: .normal)
        btn.setTitle(" 2885030819", for: .normal)
        btn.setTitleColor(UIColor.Global.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat.FontSize._14)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(didClickQQButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var phoneButtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "phone_buttonImage_about"), for: .normal)
        btn.setTitle(" 027-87263816", for: .normal)
        btn.setTitleColor(UIColor.Global.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat.FontSize._14)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(didClickPhoneButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var mainPhontButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(didClickMainPhoneButtonAction), for: .touchUpInside)
        btn.setTitle("全国统一客服热线 : 400-0057-365", for: .normal)
        btn.setTitleColor(UIColor.Global.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat.FontSize._14)
        btn.sizeToFit()
        return btn
    }()
    
    lazy var bottomTitle: UILabel = {
        let lbl = UILabel(text: "Copyright ©2018, All Rights Reserved", textColor: UIColor.Global.lightGray, fontSize: CGFloat.FontSize._12)
        lbl.sizeToFit()
        return lbl
    }()
    
    override func viewDidLoad() {
        setupUI()
    }
}

extension XHAboutViewController {
    fileprivate func setupUI() {
        title = "关于学煌"
        view.backgroundColor = UIColor.white
        view.addSubview(logoView)
        view.addSubview(qqButton)
        view.addSubview(phoneButtn)
        view.addSubview(mainPhontButton)
        view.addSubview(bottomTitle)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        logoView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(UIDevice.iPhoneX ? 120 : 100)
            make.centerX.equalTo(view)
        }
        
        qqButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        
        phoneButtn.snp.makeConstraints { (make) in
            make.top.equalTo(qqButton.snp.bottom).offset(10)
            make.leading.equalTo(qqButton)
        }
        
        mainPhontButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneButtn.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        bottomTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-XHMargin._44)
            make.centerX.equalTo(view)
        }
    }
}

extension XHAboutViewController {
    ///< 点击了QQ按钮
    @objc
    fileprivate func didClickQQButtonAction(sender: UIButton) {
    
    }
    
    ///< 点击了打客服电话按钮
    @objc
    fileprivate func didClickPhoneButtonAction(sender: UIButton) {
        
    }
    
    ///< 点击了全国客服电话按钮
    @objc
    fileprivate func didClickMainPhoneButtonAction(sender: UIButton) {
        
    }
}
