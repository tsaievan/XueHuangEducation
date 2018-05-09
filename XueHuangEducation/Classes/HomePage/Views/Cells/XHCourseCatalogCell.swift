//
//  XHCourseCatalogCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - 首页分类的button
class XHCourseCatalogButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = RADIUS_HOMEPAGE_CATALOG_BUTTON
        layer.masksToBounds = true
        layer.borderWidth = 1.5
        layer.borderColor = COLOR_CATALOG_BUTTON_BORDER_COLOR.cgColor
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
    
    var catalogs: [XHCourseCatalog]? {
        didSet {
            guard let models = catalogs else {
                return
            }
            ///< 循环创建button
            let buttonW = (XHSCreen.width - 4.0 * MARGIN_GLOBAL_15) / 3
            let buttonH = HEIGHT_HOMEPAGE_CATALOG_BUTTON
            for (index, model) in models.enumerated() {
                let btn = XHCourseCatalogButton(type: .custom)
                btn.tag = index
                addSubview(btn)
                btn.snp.makeConstraints({ (make) in
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                    if let beforeButton = beforeButton {
                        if index % 3 == 0 { ///< 第一列
                            make.left.equalTo(self).offset(MARGIN_GLOBAL_15)
                        }else {
                            make.left.equalTo(beforeButton.snp.right).offset(MARGIN_GLOBAL_15)
                        }
                    make.top.equalTo(self).offset(MARGIN_GLOBAL_10 + (CGFloat(index / 3) * (buttonH + MARGIN_GLOBAL_10)))
                    }else {
                        make.top.equalTo(self).offset(MARGIN_GLOBAL_10)
                        make.left.equalTo(self).offset(MARGIN_GLOBAL_15)
                    }
                    
                })
                btn.setTitle(model.courseClassName, for: .normal)
                btn.setTitleColor(COLOR_CATALOG_BUTTON_TITLE_COLOR, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
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
                make.bottom.equalTo(last).offset(MARGIN_GLOBAL_10)
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

