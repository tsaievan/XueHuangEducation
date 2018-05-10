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
        iv.isUserInteractionEnabled = false
        iv.backgroundColor = COLOR_HOMEPAGE_COURSE_ICON_BLUE
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "image_homepage_courseIcon"))
        iv.isUserInteractionEnabled = false
        return iv
    }()
    
    lazy var iconLabel: UILabel = {
        let lbl = UILabel(text: "课程", textColor: .white, fontSize: 20)
        return lbl
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        if UIDevice.iPhoneSE {
            lbl.font = UIFont.systemFont(ofSize: CGFloat.FontSize._13)
        }else {
            lbl.font = UIFont.systemFont(ofSize: CGFloat.FontSize._16)
        }
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
            make.top.equalTo(iconView.snp.bottom).offset(XHMargin._15)
            make.leading.trailing.equalTo(iconView)
        }
    }
}

protocol XHNetCourseButtonsContainterViewDelegate: NSObjectProtocol {
    func netCourseButtonsContainterViewDidNetCourseButton(containterView: XHNetCourseButtonsContainterView, sender: UIControl)
}

///< 首页课程分类的button的容器
class XHNetCourseButtonsContainterView: UIView {
    
    var xh_delegate: XHNetCourseButtonsContainterViewDelegate?
    
    lazy var tipView: UIView = {
        let t = UIView()
        t.backgroundColor = UIColor.Global.skyBlue
        t.layer.cornerRadius = 2
        t.layer.masksToBounds = true
        return t
    }()
    
    lazy var tipLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_HOMEPAGE_TIP_LABEL_COLOR, fontSize: CGFloat.FontSize._16)
        return lbl
    }()
    
    ///< 最后一个按钮
    var lastButton: XHNetCourseButton?
    
    ///< 上一个按钮
    var beforeButton: XHNetCourseButton?
    
    ///< 由于这个方法会调用多次, 会造成创建多次button的bug
    ///< 那么需要判断lastButton是否有值
    ///< 如果有值, 就表明已经创建过了, 直接return
    var catalogs: [XHNetCourse]? {
        didSet {
            guard let models = catalogs,
            let first = models.first,
            let title = first.catalogName else {
                return
            }
            tipLabel.text = title
            if lastButton != nil {
                return
            }
            ///< 循环创建button
            let buttonW = (XHSCreen.width - 2.0 * XHMargin._25) / 2
            let buttonH: CGFloat = 160
            for (index, model) in models.enumerated() {
                let btn = XHNetCourseButton()
                btn.tag = index
                addSubview(btn)
                btn.snp.makeConstraints({ (make) in
                    make.width.equalTo(buttonW)
                    make.height.equalTo(buttonH)
                    if let beforeButton = beforeButton {
                        if index % 2 == 0 { ///< 第一列
                            make.left.equalTo(self).offset(XHMargin._10)
                        }else {
                            make.left.equalTo(beforeButton.snp.right).offset(XHMargin._10)
                        }
                        make.top.equalTo(tipView.snp.bottom).offset(XHMargin._10 + (CGFloat(index / 2) * (buttonH + XHMargin._10)))
                    }else {
                        make.top.equalTo(tipView.snp.bottom).offset(XHMargin._10)
                        make.left.equalTo(self).offset(XHMargin._10)
                    }
                })
                btn.model = model
                if index == models.count - 1 { ///< 表明是最后一个按钮
                    lastButton = btn
                }
                beforeButton = btn
                btn.addTarget(self, action: #selector(didNetCourseCatalogButtonAction), for: .touchUpInside)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHNetCourseButtonsContainterView {
    @objc
    fileprivate func didNetCourseCatalogButtonAction(sender: UIControl) {
        xh_delegate?.netCourseButtonsContainterViewDidNetCourseButton(containterView: self, sender: sender)
    }
}

extension XHNetCourseButtonsContainterView {
    fileprivate func setupUI() {
        addSubview(tipView)
        addSubview(tipLabel)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        tipView.snp.makeConstraints { (make) in
            make.top.equalTo(XHMargin._10)
            make.left.equalTo(XHMargin._10)
            make.width.equalTo(4)
            make.height.equalTo(15)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipView)
            make.left.equalTo(tipView.snp.right).offset(XHMargin._10)
        }
    }
}


class XHNetCourseCell: UITableViewCell {
    
    lazy var buttonsView: XHNetCourseButtonsContainterView = {
        let cv = XHNetCourseButtonsContainterView()
        cv.xh_delegate = self
        cv.layer.cornerRadius = 5
        cv.layer.masksToBounds = true
        cv.backgroundColor = .white
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
        backgroundColor = UIColor.Global.background
        contentView.backgroundColor = .clear
        contentView.addSubview(buttonsView)
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        buttonsView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(XHMargin._10)
            make.right.equalTo(contentView).offset(-XHMargin._10)
            make.bottom.equalTo(contentView).priority(.low)
        }
    }
}

extension XHNetCourseCell: XHNetCourseButtonsContainterViewDelegate {
    func netCourseButtonsContainterViewDidNetCourseButton(containterView: XHNetCourseButtonsContainterView, sender: UIControl) {
        guard let models = catalogs else {
            return
        }
        router(withEventName: EVENT_CLICK_COURSE_BUTTON, userInfo: [MODEL_CLICK_COURSE_BUTTON : models[sender.tag],
                                                                    CELL_FOR_COURSE_BUTTON: self])
    }
}
