//
//  XHCatalogListSegmentView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import pop

// MARK: - XHCatalogListSegmentView协议
protocol XHCatalogListSegmentViewDelegate: NSObjectProtocol {
    func catalogListSegmentViewDidClickSegmentButton(segmentView: XHCatalogListSegmentView, sender: XHButton)
}

extension String {
    struct CatalogListSegmentView {
        static let myTeachButtonImageName = "image_profile_myTeach"
        static let myThemeButtonImageName = "image_profile_myTheme"
        static let myQuestionButtonImageName = "image_profile_myQuestion"
    }
    
    struct ButtonTitle {
        static let myTeachButton = "网校讲题"
        static let myThemeButton = "在线做题"
        static let myQuestionButton = "在线问答"
    }
    
    static let XHButtonClassName = "XHButton"
}

fileprivate let myTeachButtonImageName = String.CatalogListSegmentView.myTeachButtonImageName
fileprivate let myThemeButtonImageName = String.CatalogListSegmentView.myThemeButtonImageName
fileprivate let myQuestionButtonImageName = String.CatalogListSegmentView.myQuestionButtonImageName

fileprivate let myTeachButton_normal = String.ButtonTitle.myTeachButton
fileprivate let myThemeButton_normal = String.ButtonTitle.myThemeButton
fileprivate let myQuestionButton_normal = String.ButtonTitle.myQuestionButton

class XHCatalogListSegmentView: UIView {
    
    weak var xh_delegate: XHCatalogListSegmentViewDelegate?
    
    ///< 水平方向的缩放系数
    let horizontalScale = UIDevice.horizontalScale
    
    ///< 上一个被点击的button
    var lastButton: XHButton?
    
    // MARK: - 懒加载
    lazy var myTeachButton: XHButton = {
        let btn = XHButton(withButtonImage: myTeachButtonImageName, title: myTeachButton_normal, titleFont: CGFloat.FontSize._13, gap: 0)
        btn.tag = XHButtonType.teach.rawValue
        btn.addTarget(self, action: #selector(didClickSegmentViewButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var myThemeButton: XHButton = {
        let btn = XHButton(withButtonImage: myThemeButtonImageName, title: myThemeButton_normal, titleFont: CGFloat.FontSize._13, gap: 0)
        btn.tag = XHButtonType.theme.rawValue
        btn.addTarget(self, action: #selector(didClickSegmentViewButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var myQuestionButton: XHButton = {
        let btn = XHButton(withButtonImage: myQuestionButtonImageName, title: myQuestionButton_normal, titleFont: CGFloat.FontSize._13, gap: 0)
        btn.tag = XHButtonType.answer.rawValue
        btn.addTarget(self, action: #selector(didClickSegmentViewButtonAction), for: .touchUpInside)
        return btn
    }()
    
    var selectedPage: Int = XHButtonType.theme.rawValue {
        didSet {
            if selectedPage == XHButtonType.teach.rawValue {
                didClickSegmentViewButtonAction(sender: myTeachButton)
            }else if selectedPage == XHButtonType.theme.rawValue {
                didClickSegmentViewButtonAction(sender: myThemeButton)
            }else {
                didClickSegmentViewButtonAction(sender: myQuestionButton)
            }
        }
    }
    
    // MARK: - init方法
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
            make.left.equalTo(self).offset(XHMargin._44 * horizontalScale)
            make.width.equalTo((XHSCreen.width - 2 * (XHMargin._44 * horizontalScale + XHMargin._44 * horizontalScale)) / 3)
        }
        
        myThemeButton.snp.makeConstraints { (make) in
            make.left.equalTo(myTeachButton.snp.right).offset(XHMargin._44 * horizontalScale)
            make.top.width.equalTo(myTeachButton)
        }
        
        myQuestionButton.snp.makeConstraints { (make) in
            make.left.equalTo(myThemeButton.snp.right).offset(XHMargin._44 * horizontalScale)
            make.top.width.equalTo(myThemeButton)
        }
    }
}


// MARK: - 按钮点击事件
extension XHCatalogListSegmentView {
    @objc
    fileprivate func didClickSegmentViewButtonAction(sender: XHButton) {
        guard let bundleName = Bundle.bundleName,
        let kls = NSClassFromString(bundleName + String.point + String.XHButtonClassName) else {
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
