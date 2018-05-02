//
//  XHTeachSectionHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

typealias XHTapTeachSectionHeaderView = () -> ()

class XHTeachSectionHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: nil, fontSize: 16)
        return lbl
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "image_homepage_downArrow"), for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    var model: XHCourseCatalog? {
        didSet {
            guard let m = model,
            let isFold = m.isFold else {
                return
            }
            titleLabel.text = m.courseClassName
            button.transform = isFold ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat(-Double.pi * 0.5))
        }
    }
    
    var tapSectionClosure: XHTapTeachSectionHeaderView?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        addGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHTeachSectionHeaderView {
    fileprivate func setupUI() {
        backgroundView?.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(button)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_25)
        }
        
        button.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-MARGIN_GLOBAL_15)
        }
    }
}

// MARK: - 设置点击事件
extension XHTeachSectionHeaderView {
    fileprivate func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTeachSectionHeaderView))
        addGestureRecognizer(tap)
    }
    
    @objc
    fileprivate func didTapTeachSectionHeaderView(sender: UITapGestureRecognizer) {
        tapSectionClosure?()
    }
}
