//
//  XHCourseCatalogCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit

extension UIColor {
    struct CourseCatalogButton {
        static let border = UIColor(hexColor: "#CCCCCC")
    }
}

extension CGFloat {
    struct CourseCatalogButton {
        struct Width {
            static let buttonBorder: CGFloat = 0.5
        }
        
        struct Height {
            static let button: CGFloat = 30.0
        }
        
        struct CornerRadius {
            static let button: CGFloat = 15.0
        }
    }
}

fileprivate let buttonBorder = CGFloat.CourseCatalogButton.Width.buttonBorder
fileprivate let buttonHeight = CGFloat.CourseCatalogButton.Height.button
fileprivate let buttonCornerRadius = CGFloat.CourseCatalogButton.CornerRadius.button

// MARK: - 首页分类的button
class XHCourseCatalogButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = buttonCornerRadius
        layer.masksToBounds = true
        layer.borderWidth = buttonBorder
        layer.borderColor = UIColor.CourseCatalogButton.border.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol XHCourseCatalogButtonsContainterViewDelegate: NSObjectProtocol {
    func courseCatalogButtonsContainterViewDidClickCatalogButton(containterView: XHCourseCatalogButtonsContainterView, sender: UIButton)
}

// MARK: - 首页课程分类的button的容器
class XHCourseCatalogButtonsContainterView: UIView {
    
    ///< 代理
    var xh_delegate: XHCourseCatalogButtonsContainterViewDelegate?
    ///< 最后一个按钮
    var lastButton: XHCourseCatalogButton?
    
    ///< 上一个按钮
    var beforeButton: XHCourseCatalogButton?
    
    ///< 由于这个方法会调用多次, 会造成创建多次button的bug
    ///< 那么需要判断lastButton是否有值
    ///< 如果有值, 就表明已经创建过了, 直接return
    var catalogs: [XHCourseCatalog]? {
        didSet {
            guard let models = catalogs else {
                return
            }
            if lastButton != nil {
                return
            }
            ///< 循环创建button
            let buttonW = (XHSCreen.width - 4.0 * XHMargin._15) / 3
            let buttonH = buttonHeight
            for (index, model) in models.enumerated() {
                let btn = XHCourseCatalogButton(type: .custom)
                btn.tag = index
                addSubview(btn)
                btn.snp.makeConstraints({ (make) in
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                    if let beforeButton = beforeButton {
                        if index % 3 == 0 { ///< 第一列
                            make.left.equalTo(self).offset(XHMargin._15)
                        }else {
                            make.left.equalTo(beforeButton.snp.right).offset(XHMargin._15)
                        }
                    make.top.equalTo(self).offset(XHMargin._10 + (CGFloat(index / 3) * (buttonH + XHMargin._10)))
                    }else {
                        make.top.equalTo(self).offset(XHMargin._10)
                        make.left.equalTo(self).offset(XHMargin._15)
                    }
                    
                })
                btn.setTitle(model.courseClassName, for: .normal)
                btn.setTitleColor(COLOR_CATALOG_BUTTON_TITLE_COLOR, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat.FontSize._14)
                btn.addTarget(self, action: #selector(didClickCourseCatalogButtonAction), for: .touchUpInside)
                if index == models.count - 1 { ///< 表明是最后一个按钮
                    lastButton = btn
                }
                beforeButton = btn
            }
            
            ///< 将bottom的底部设置与最后一个button的bottom相同
            guard let last = lastButton else {
                return
            }
            self.snp.makeConstraints({ (make) in
                make.bottom.equalTo(last).offset(XHMargin._10)
            })
            layoutIfNeeded()
        }
    }
}

extension XHCourseCatalogButtonsContainterView {
    @objc
    fileprivate func didClickCourseCatalogButtonAction(sender: UIButton) {
        xh_delegate?.courseCatalogButtonsContainterViewDidClickCatalogButton(containterView: self, sender: sender)
    }
}

// MARK: - XHCourseCatalogCell
class XHCourseCatalogCell: UITableViewCell {
    
    lazy var buttonsView: XHCourseCatalogButtonsContainterView = {
        let cv = XHCourseCatalogButtonsContainterView()
        cv.backgroundColor = UIColor.Global.background
        cv.xh_delegate = self
        return cv
    }()
    
    var catalogs: [XHCourseCatalog]? {
        didSet {
            buttonsView.catalogs = catalogs
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHCourseCatalogCell {
    fileprivate func setupUI() {
        contentView.addSubview(buttonsView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        buttonsView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).priority(.low)
        }
    }
}

extension XHCourseCatalogCell: XHCourseCatalogButtonsContainterViewDelegate {
    func courseCatalogButtonsContainterViewDidClickCatalogButton(containterView: XHCourseCatalogButtonsContainterView, sender: UIButton) {
        guard let models = catalogs else {
            return
        }
        if models.count > sender.tag {
            router(withEventName: EVENT_CLICK_CATALOG_BUTTON, userInfo: [MODEL_CLICK_CATALOG_BUTTON : models[sender.tag]])
        }
    }
}

