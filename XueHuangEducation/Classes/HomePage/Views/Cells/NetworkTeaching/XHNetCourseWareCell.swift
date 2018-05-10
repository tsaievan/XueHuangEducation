//
//  XHNetCourseWareCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

enum XHNetCourseWareState: Int{
    case free = 0
    case charge = 2
}

extension UIColor {
    struct NetCourseWareCell {
        static let teacherLabel = UIColor(hexColor: "#777777")
        static let titleLabel = UIColor(hexColor: "#333333")
    }
}

extension CGFloat {
    struct NetCourseWareCell {
        struct Width {
            static let iconImageView: CGFloat = 80
            static let listenButton: CGFloat = 28
        }
    }
}

extension String {
    struct NetCourseWareCell {
        static let listenButtonImageName = "catalogList_listen_button"
        static let iconImageName = "image_teach_courseware"
        static let listenButtonTitle = "试听"
        static let listenButtonPayTitle = "付费"
    }
}

fileprivate let listenButtonImageName = String.NetCourseWareCell.listenButtonImageName
fileprivate let iconImageName = String.NetCourseWareCell.iconImageName
fileprivate let listenButtonTitleText = String.NetCourseWareCell.listenButtonTitle
fileprivate let listenButtonTitlePayText = String.NetCourseWareCell.listenButtonPayTitle

fileprivate let iconImageViewWidth = CGFloat.NetCourseWareCell.Width.iconImageView
fileprivate let listenButtonWidth = CGFloat.NetCourseWareCell.Width.listenButton

class XHNetCourseWareCell: UITableViewCell {
    var model: XHNetCourseWare? {
        didSet {
            guard let modelInfo = model,
            let titleText = modelInfo.netCoursewareName,
            let teacherName = modelInfo.teacher else {
                return
            }
            titleLabel.text = titleText
            teacherLabel.text = "老师: \(teacherName)"
            if let state = modelInfo.state {
                if state == XHNetCourseWareState.free.rawValue {
                    listenButton.titleLabel?.text = listenButtonTitleText
                }else {
                    listenButton.titleLabel?.text = listenButtonTitlePayText
                }
            }
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: iconImageName)
        imageView.layer.cornerRadius = CGFloat.commonCornerRadius
        imageView.layer.masksToBounds = true
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: UIColor.NetCourseWareCell.titleLabel, fontSize: CGFloat.FontSize._15)
        lbl.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._15)
        lbl.numberOfLines = 2 ///< 防止有些标题过长, 在iPhoneSE等小机型下转到第三行, 跟teacherLabel相冲突
        return lbl
    }()
    
    lazy var teacherLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: UIColor.NetCourseWareCell.teacherLabel, fontSize: CGFloat.FontSize._13)
        return lbl
    }()
    
    lazy var listenButton: XHButton = {
        let btn = XHButton(withButtonImage: listenButtonImageName, title: listenButtonTitleText, titleColor: UIColor.Global.skyBlue, titleFont: CGFloat.FontSize._12, gap: CGFloat.zero)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHNetCourseWareCell {
    fileprivate func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(teacherLabel)
        contentView.addSubview(listenButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(XHMargin._10)
            make.left.equalTo(contentView).offset(XHMargin._15)
            make.bottom.equalTo(contentView).offset(-XHMargin._10)
            make.width.equalTo(iconImageViewWidth)
        }
        
        listenButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(contentView).offset(-XHMargin._15)
            make.width.equalTo(listenButtonWidth)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(XHMargin._10)
            make.right.equalTo(listenButton.snp.left).offset(-XHMargin._10)
        }
        
        teacherLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(iconImageView)
        }
    }
}
