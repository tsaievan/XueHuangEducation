//
//  XHProfileCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 12/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

enum XHProfileSwithType: Int {
    case cacheVideo = 0 ///< 允许缓存视频
    case pushInfo = 1 ///< 允许消息推送
}

class XHProfileCell: UITableViewCell {
    
    var model: XHProfileInfoModel? {
        didSet {
            guard let info = model else {
                return
            }
            titleLabel.text = info.title
            if let accessory = info.accessory {
                if accessory == .xhSwitch {
                    xhSwitch.isHidden = false
                    accessoryType = .none
                }else {
                    xhSwitch.isHidden = true
                    accessoryType = .disclosureIndicator
                }
            }
            if let isOn = info.switchIsOn {
                xhSwitch.isOn = isOn
            }else {
                xhSwitch.isOn = true
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: UIColor.Global.darkGray, fontSize: CGFloat.FontSize._13)
        return lbl
    }()
    
    lazy var xhSwitch: UISwitch = {
        let s = UISwitch()
        ///< 默认打开开关
        s.tintColor = UIColor.Global.skyBlue
        s.onTintColor = UIColor.Global.skyBlue
        s.addTarget(self, action: #selector(didSwitchAction), for: .valueChanged)
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
            make.left.equalTo(contentView).offset(XHMargin._15).priority(.low)
        }
        
        xhSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-XHMargin._15).priority(.low)
        }
    }
}

extension XHProfileCell {
    @objc
    fileprivate func didSwitchAction(sender: UISwitch) {
        router(withEventName: EVENT_PROFILE_CELL_SWITCH_ON_AND_OFF, userInfo: [
            PROFILE_CELL_FOR_SWITCH: self,
            PROFILE_CELL_SWITCH_SELF: sender
            ])
    }
}
