//
//  XHQuestionListCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHQuestionListCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: nil, fontSize: 16)
        return lbl
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "image_homepage_rightArrow"), for: .normal)
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHQuestionListCell {
    fileprivate func setupUI() {
        backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_25)
        }
        
        button.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_15)
        }
    }
}

