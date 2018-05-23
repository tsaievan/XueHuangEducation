//
//  XHAdvertisementView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 23/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHAdvertisementView: UIView {
    
    var content: String? {
        didSet {
            guard let con = content else {
                return
            }
            webView.loadHTMLString(con, baseURL: nil)
        }
    }
    
    lazy var webView: UIWebView = {
        let web = UIWebView()
        web.backgroundColor = .white
        web.layer.cornerRadius = 10
        web.layer.masksToBounds = true
        return web
    }()
    
    lazy var indicatorView: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = COLOR_ADVERTISEMENT_BORDER
        return indicator
    }()
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "button_advertisement_dismiss"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(dismissAdvertisementView), for: .touchUpInside)
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

extension XHAdvertisementView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        addSubview(webView)
        addSubview(indicatorView)
        addSubview(dismissButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        webView.snp.makeConstraints { (make) in
            make.width.equalTo(XHSCreen.width * 2 / 3)
            make.height.equalTo(XHSCreen.height / 3)
            make.center.equalTo(self)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.width.equalTo(2)
            make.height.equalTo(80)
            make.bottom.equalTo(webView.snp.top)
            make.trailing.equalTo(webView).offset(-XHMargin._15)
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(indicatorView.snp.top).offset(2)
            make.centerX.equalTo(indicatorView)
        }
    }
}

extension XHAdvertisementView {
    @objc
    fileprivate func dismissAdvertisementView(sender: UIButton)  {
        removeFromSuperview()
    }
}
