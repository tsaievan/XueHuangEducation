//
//  XHCourseCatalogCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit

///< 首页分类的button
class XHCourseCatalogButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 1.5
        layer.borderColor = COLOR_CATALOG_BUTTON_BORDER_COLOR.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///< 首页课程分类的button的容器
class XHCourseCatalogButtonsContainterView: UIView {
    
    var lastButton: XHCourseCatalogButton?
    
    var catalogs: [XHCourseCatalog]? {
        didSet {
            guard let models = catalogs else {
                return
            }
            ///< 循环创建button
            let buttonW = (SCREEN_WIDTH - 4.0 * MARGIN_GLOBAL_15) / 3
            let buttonH = HEIGHT_HOMEPAGE_CATALOG_BUTTON
            for (index, model) in models.enumerated() {
                let btn = XHCourseCatalogButton(type: .custom)
                btn.x = MARGIN_GLOBAL_15 + (CGFloat(index % 3) * (buttonW + MARGIN_GLOBAL_15))
                btn.y = MARGIN_GLOBAL_15 + (CGFloat(index / 3) * (buttonH + MARGIN_GLOBAL_15))
                btn.width = buttonW
                btn.height = buttonH
                btn.setTitle(model.courseClassName, for: .normal)
                btn.setTitleColor(COLOR_CATALOG_BUTTON_TITLE_COLOR, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: FONT_SIZE_14)
                if index == models.count - 1 { ///< 表明是最后一个按钮
                    lastButton = btn
                    height = btn.y + btn.height
                    print("\(height)")
                    layoutIfNeeded()
                }
                addSubview(btn)
            }
        }
    }
}

class XHCourseCatalogCell: UITableViewCell {
    
    lazy var buttonsView: XHCourseCatalogButtonsContainterView = {
        let cv = XHCourseCatalogButtonsContainterView()
        cv.backgroundColor = .cyan
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
        
    }
}
