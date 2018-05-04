//
//  XHCatalogListSegmentView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import pop

protocol XHCatalogListSegmentViewDelegate: NSObjectProtocol {
    func catalogListSegmentViewDidClickSegmentButton(segmentView: XHCatalogListSegmentView, sender: XHButton)
}

class XHCatalogListSegmentView: UIView {
    
    weak var xh_delegate: XHCatalogListSegmentViewDelegate?
    
    ///< 水平方向的缩放系数
    let horizontalScale = UIDevice.horizontalScale
    
    ///< 上一个被点击的button
    var lastButton: XHButton?
    
    lazy var myTeachButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myTeach", title: "网校讲题", titleFont: FONT_SIZE_13, gap: 0)
        btn.tag = XHButtonType.teach.rawValue
        btn.addTarget(self, action: #selector(didClickSegmentViewButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var myThemeButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myTheme", title: "在线做题", titleFont: FONT_SIZE_13, gap: 0)
        btn.tag = XHButtonType.theme.rawValue
        btn.addTarget(self, action: #selector(didClickSegmentViewButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var myQuestionButton: XHButton = {
        let btn = XHButton(withButtonImage: "image_profile_myQuestion", title: "在线问答", titleFont: FONT_SIZE_13, gap: 0)
        btn.tag = XHButtonType.answer.rawValue
        btn.addTarget(self, action: #selector(didClickSegmentViewButtonAction), for: .touchUpInside)
        return btn
    }()
    
    var selectedPage: Int = 1 {
        didSet {
            if selectedPage == 0 {
                didClickSegmentViewButtonAction(sender: myTeachButton)
            }else if selectedPage == 1 {
                didClickSegmentViewButtonAction(sender: myThemeButton)
            }else {
                didClickSegmentViewButtonAction(sender: myQuestionButton)
            }
        }
    }
    
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
        didClickSegmentViewButtonAction(sender: myTeachButton)
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

extension XHCatalogListSegmentView {
    @objc
    fileprivate func didClickSegmentViewButtonAction(sender: XHButton) {
        guard let bundleName = Bundle.bundleName,
        let kls = NSClassFromString(bundleName + "." + "XHButton") else {
            return
        }
        for button in subviews {
            if button.isKind(of: kls) {
                let scaleAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
                let scale = (sender == button) ? 1 : 0.8
                scaleAnim.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
                scaleAnim.duration = 0.2
                button.pop_add(scaleAnim, forKey: nil)
            }
        }
        xh_delegate?.catalogListSegmentViewDidClickSegmentButton(segmentView: self, sender: sender)
    }
}
