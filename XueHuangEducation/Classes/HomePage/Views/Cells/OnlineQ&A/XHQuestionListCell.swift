//
//  XHQuestionListCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHQuestionListCell: UITableViewCell {
    
    lazy var countView: UIView = {
        let tv = UIView()
        tv.layer.cornerRadius = CGFloat.smallCornerRadius
        tv.layer.masksToBounds = true
        tv.backgroundColor = COLOR_QUESTION_COUNT_LABEL_LIGHT_GRAY
        return tv
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: nil, fontSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "image_homepage_rightArrow"), for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    lazy var countLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: .white, fontSize: 13)
        lbl.textColor = .white
        return lbl
    }()
    
    var model: XHCourseCatalog? {
        didSet {
            guard let m = model,
                let count = m.queCount else {
                    return
            }
            titleLabel.text = m.courseClassName
            countLabel.text = "\(count)"
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
        countView.addSubview(countLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        contentView.addSubview(countView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {

        countView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(titleLabel.snp.right).offset(XHMargin._10)
            make.top.equalTo(countLabel).offset(-XHMargin._2).priority(.low)
            make.left.equalTo(countLabel).offset(-XHMargin._5).priority(.low)
            make.bottom.equalTo(countLabel).offset(XHMargin._2).priority(.low)
            make.right.equalTo(countLabel).offset(XHMargin._5).priority(.low)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(XHMargin._25)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.center.equalTo(countView)
        }
        
        button.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-XHMargin._15)
        }
    }
}

