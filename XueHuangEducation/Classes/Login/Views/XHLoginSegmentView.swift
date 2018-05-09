//
//  XHLoginSegmentView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit

protocol XHLoginSegmentViewDelegate: NSObjectProtocol {
    func loginSegmentViewDidClick(sender: UIButton, segmentView: XHLoginSegmentView)
}

class XHLoginSegmentView: UIView {
    ///< SegmentView的代理
    weak var xh_delegate: XHLoginSegmentViewDelegate?
    
    ///< 账号登录选择按钮
    lazy var accountButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("账号登录", for: .normal)
        btn.setTitleColor(UIColor.Global.darkGray, for: .normal)
        btn.setTitleColor(UIColor.Global.skyBlue, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.tag = 0
        btn.addTarget(self, action: #selector(didClickSegmentButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///< 手机登录选择按钮
    lazy var phoneButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("手机快捷登录", for: .normal)
        btn.setTitleColor(UIColor.Global.darkGray, for: .normal)
        btn.setTitleColor(UIColor.Global.skyBlue, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.tag = 1
        btn.addTarget(self, action: #selector(didClickSegmentButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///< 提示的蓝色线
    lazy var tipView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.Global.skyBlue
        return v
    }()
    
    ///< 灰色背景的分割线
    lazy var seperatorView: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor.Global.lightGray
        return s
    }()
    
    ///< 记录上一次点击的button
    var lastButton: UIButton?
    
    ///< 记录是翻到了哪一页
    ///< 0: 账号登录
    ///< 1: 手机登录
    var selectedPage: Int = 0 {
        didSet {
            if selectedPage == 0 {
                didClickSegmentButtonAction(sender: accountButton)
            }else {
                didClickSegmentButtonAction(sender: phoneButton)
            }
        }
    }
    
    ///< 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHLoginSegmentView {
    fileprivate func setupUI() {
        backgroundColor = .white
        addSubview(accountButton)
        addSubview(phoneButton)
        addSubview(seperatorView)
        seperatorView.addSubview(tipView)
        makeConstraints()
        accountButton.isSelected = true
        lastButton = accountButton
    }
    
    fileprivate func makeConstraints() {
        accountButton.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(XHSCreen.width * 0.5)
        }
        
        phoneButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(XHSCreen.width * 0.5)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(2)
        }
        
        tipView.snp.makeConstraints { (make) in
            make.centerX.equalTo(accountButton.snp.centerX)
            make.bottom.equalTo(seperatorView)
            make.width.equalTo(XHSCreen.width * 0.5)
            make.height.equalTo(2)
        }
    }
}

// MARK: - 按钮点击事件
extension XHLoginSegmentView {
    @objc fileprivate func didClickSegmentButtonAction(sender: UIButton) {
        sender.isSelected = true
        lastButton?.isSelected = false
        lastButton = sender
        tipView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(sender.snp.centerX)
            make.bottom.equalTo(self)
            make.width.equalTo(XHSCreen.width * 0.5)
            make.height.equalTo(2)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        xh_delegate?.loginSegmentViewDidClick(sender: sender, segmentView: self)
    }
}

