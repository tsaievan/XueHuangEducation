//
//  XHLoginView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 15/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

enum XHLoginType {
    case account ///< 账号
    case phone ///< 密码
    case reset ///< 找回密码
}

@objc
protocol XHLoginViewDelegate: NSObjectProtocol {
    @objc optional
    func loginViewDidLogin(loginView: XHLoginView)
    @objc optional
    func loginViewDidGetAuthCode(loginView: XHLoginView)
    @objc optional
    func loginViewDidRegist(loginView: XHLoginView)
    @objc optional
    func loginViewDidRestPassword(loginView: XHLoginView)
}

class XHLoginView: UIView {
    
    ///< 选择账号登录还是手机登录的segment
    lazy var segmentView: XHLoginSegmentView = {
        let s = XHLoginSegmentView(frame: CGRect.zero)
        s.xh_delegate = self
        return s
    }()
    
    ///< 滚动账号登录和手机登录的scrollView
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: CGRect.zero)
        sv.delegate = self
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.bounces = false
        sv.isPagingEnabled = true
        return sv
    }()
    
    ///< 包裹账号登录和手机登录的contentView
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    ///< 账号登录的view
    lazy var accountLoginView: XHLoginDetailView = {
       let av = XHLoginDetailView(loginType: .accountLogin)
        av.xh_delegate = self
        return av
    }()
    
    ///< 手机登录的view
    lazy var phoneLoginView: XHLoginDetailView = {
        let pv = XHLoginDetailView(loginType: .phoneLogin)
        pv.xh_delegate = self
        return pv
    }()
    
    ///< loginView的代理
    weak var xh_delegate: XHLoginViewDelegate?
    
    ///< 登录类型
    var loginType: XHLoginViewType?
    
    ///< 登录信息
    var info: XHLoginDetailViewInfo?
    
    ///< 获取验证码的按钮是否禁用
    var getAuthButtonEnable: Bool? {
        didSet {
            phoneLoginView.getAuthButtonEnable = getAuthButtonEnable
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
extension XHLoginView {
    fileprivate func setupUI() {
        backgroundColor = .white
        addSubview(scrollView)
        addSubview(segmentView)
        contentView.addSubview(accountLoginView)
        contentView.addSubview(phoneLoginView)
        scrollView.addSubview(contentView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        segmentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.bottom.right.equalTo(self)
        }
        
        contentView.snp.makeConstraints { (make) in
            ///< 上下锁定
            make.top.bottom.equalTo(self)
            ///< 左右与scrollView对齐, 这样就给定了scrollView的contentSize
            make.left.right.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH * 2)
        }
        
        accountLoginView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.bottom.equalTo(contentView)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        phoneLoginView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.right.equalTo(contentView)
            make.width.equalTo(SCREEN_WIDTH)
        }
    }
}

// MARK: - UIScrollViewDelegate代理
extension XHLoginView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isEqual(self.scrollView) {
            if scrollView.contentOffset.x > SCREEN_WIDTH * 0.6 { ///< 偏移量超过屏幕宽度的0.6, 就设置为第1页
                segmentView.selectedPage = 1
            }else { ///< 否则返回第0页
                segmentView.selectedPage = 0
            }
        }
    }
}

// MARK: - XHLoginSegmentViewDelegate代理
extension XHLoginView: XHLoginSegmentViewDelegate {
    func loginSegmentViewDidClick(sender: UIButton, segmentView: XHLoginSegmentView) {
        switch sender.tag {
        case 0:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: true)
        default:
            break
        }
    }
}

// MARK: - XHLoginDetailViewDelegate代理
extension XHLoginView: XHLoginDetailViewDelegate {
    func loginDetailViewDidClickLoginButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        loginType = loginDetailView.viewType
        info = loginDetailView.info
        xh_delegate?.loginViewDidLogin?(loginView: self)
    }
    
    func loginDetailViewDidClickGetAuthButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        loginType = loginDetailView.viewType
        info = loginDetailView.info
        xh_delegate?.loginViewDidGetAuthCode?(loginView: self)
    }
    
    func loginDetailViewDidClickRegistButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        loginType = loginDetailView.viewType
        info = loginDetailView.info
        xh_delegate?.loginViewDidRegist?(loginView: self)
    }
    
    func loginDetailViewDidClickResetPwdButton(loginDetailView: XHLoginDetailView, sender: UIButton) {
        loginType = loginDetailView.viewType
        info = loginDetailView.info
        xh_delegate?.loginViewDidRestPassword?(loginView: self)
    }
}

extension XHLoginView {
    func setupTimer() {
        phoneLoginView.startCountingDown()
    }
}


