//
//  XHProfileCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 12/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHProfileCell: UITableViewCell {
    
    var model: XHProfileInfoModel? {
        didSet {
            guard let info = model else {
                return
            }
            titleLabel.text = info.title
        }
    }
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: nil, fontSize: CGFloat.FontSize._12)
        return lbl
    }()
    
    lazy var xhSwitch: UISwitch = {
        let s = UISwitch()
        ///< 默认打开开关
        s.isOn = true
        s.tintColor = UIColor.Global.skyBlue
        s.onTintColor = UIColor.Global.skyBlue
        
        return s
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHProfileCell {
    fileprivate func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(xhSwitch)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(XHMargin._10).priority(.low)
        }
        
        xhSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-XHMargin._10).priority(.low)
        }
    }
}
