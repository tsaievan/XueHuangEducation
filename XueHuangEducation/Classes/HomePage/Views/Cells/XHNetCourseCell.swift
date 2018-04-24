//
//  XHNetCourseCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 24/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHNetCourseButton: UIControl {
    lazy var iconView: UIView = {
        let iv = UIView()
        iv.backgroundColor = COLOR_HOMEPAGE_COURSE_ICON_BLUE
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "image_homepage_courseIcon"))
        return iv
    }()
    
    lazy var iconLabel: UILabel = {
        let lbl = UILabel(text: "课程", textColor: .white, fontSize: 20)
        return lbl
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: FONT_SIZE_16)
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
    
    var model: XHNetCourse? {
        didSet {
            
            titleLabel.text = model?.netCourseName
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

extension XHNetCourseButton {
    fileprivate func setupUI() {
        iconView.addSubview(iconImageView)
        iconView.addSubview(iconLabel)
        addSubview(iconView)
        addSubview(titleLabel)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(100)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.centerY.equalTo(iconView).offset(-10)
        }
        
        iconLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(MARGIN_GLOBAL_15)
            make.leading.trailing.equalTo(iconView)
        }
    }
}

///< 首页课程分类的button的容器
class XHNetCourseButtonsContainterView: UIView {
    ///< 最后一个按钮
    var lastButton: XHNetCourseButton?
    
    ///< 上一个按钮
    var beforeButton: XHNetCourseButton?
    
    var catalogs: [XHNetCourse]? {
        didSet {
            guard let models = catalogs else {
                return
            }
            ///< 循环创建button
            let buttonW = (SCREEN_WIDTH - 3.0 * MARGIN_GLOBAL_20) / 2
            let buttonH: CGFloat = 160
            for (index, model) in models.enumerated() {
                let btn = XHNetCourseButton()
                addSubview(btn)
                btn.snp.makeConstraints({ (make) in
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                    if let beforeButton = beforeButton {
                        if index % 2 == 0 { ///< 第一列
                            make.left.equalTo(self).offset(MARGIN_GLOBAL_25)
                        }else {
                            make.left.equalTo(beforeButton.snp.right).offset(MARGIN_GLOBAL_10)
                        }
                        make.top.equalTo(self).offset(MARGIN_GLOBAL_10 + (CGFloat(index / 2) * (buttonH + MARGIN_GLOBAL_10)))
                    }else {
                        make.top.equalTo(self).offset(MARGIN_GLOBAL_10)
                        make.left.equalTo(self).offset(MARGIN_GLOBAL_25)
                    }
                    
                })
                btn.model = model
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


class XHNetCourseCell: UITableViewCell {
    
    lazy var tipView: UIView = {
        let t = UIView()
        t.backgroundColor = COLOR_GLOBAL_BLUE
        t.layer.cornerRadius = 2
        t.layer.masksToBounds = true
        return t
    }()
    
    lazy var tipLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_HOMEPAGE_TIP_LABEL_COLOR, fontSize: FONT_SIZE_16)
        return lbl
    }()
    
    lazy var buttonsView: XHNetCourseButtonsContainterView = {
        let cv = XHNetCourseButtonsContainterView()
        cv.backgroundColor = .yellow
        return cv
    }()
    
    var catalogs: [XHNetCourse]? {
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
extension XHNetCourseCell {
    fileprivate func setupUI() {
        backgroundColor = .cyan
        contentView.addSubview(tipView)
        contentView.addSubview(tipLabel)
        contentView.addSubview(buttonsView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        tipView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
            make.width.equalTo(10)
            make.height.equalTo(27)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipView)
            make.left.equalTo(tipView.snp.right).offset(5)
        }
        
        buttonsView.snp.makeConstraints { (make) in
            make.top.equalTo(tipView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).priority(.low)
        }
    }
}
