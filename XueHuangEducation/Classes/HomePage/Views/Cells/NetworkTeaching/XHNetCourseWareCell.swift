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
                    listenButton.titleLabel?.text = "试听"
                }else {
                    listenButton.titleLabel?.text = "付费"
                }
            }
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image_teach_courseware")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_CATALOG_BUTTON_TITLE_COLOR, fontSize: FONT_SIZE_15)
        lbl.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_15)
        lbl.numberOfLines = 2 ///< 防止有些标题过长, 在iPhoneSE等小机型下转到第三行, 跟teacherLabel相冲突
        return lbl
    }()
    
    lazy var teacherLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_PAPAER_TYPE_BUTTON_TITLE, fontSize: FONT_SIZE_13)
        return lbl
    }()
    
    lazy var listenButton: XHButton = {
        let btn = XHButton(withButtonImage: "catalogList_listen_button", title: "试听", titleColor: COLOR_GLOBAL_BLUE, titleFont: FONT_SIZE_12, gap: 0)
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
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
            make.bottom.equalTo(contentView).offset(-MARGIN_GLOBAL_10)
            make.width.equalTo(80)
        }
        
        listenButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_15)
            make.width.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(MARGIN_GLOBAL_10)
            make.right.equalTo(listenButton.snp.left).offset(-MARGIN_GLOBAL_10)
        }
        
        teacherLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(iconImageView)
        }
    }
}
