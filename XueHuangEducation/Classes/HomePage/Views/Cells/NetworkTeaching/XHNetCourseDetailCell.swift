//
//  XHNetCourseDetailCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 30/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit
import SDWebImage

class XHNetCourseDetailCell: UITableViewCell {
    
    var info: (model: XHSimpleNetCourse, iconArr: String?)? {
        didSet {
            guard let imageArr = info?.iconArr,
            let newStr = (imageArr as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue),
            let model = info?.model,
            let text = model.netCourseName else {
                return
            }
            titleLabel.text = text
            iconImageView.sd_setImage(with: URL(string: newStr), placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = CGFloat.commonCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_CATALOG_BUTTON_TITLE_COLOR, fontSize: CGFloat.FontSize._16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var listenButton: XHButton = {
        let btn = XHButton(withButtonImage: "catalogList_listen_button", title: "试听", titleColor: UIColor.Global.skyBlue, titleFont: CGFloat.FontSize._12, gap: 0)
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

extension XHNetCourseDetailCell {
    fileprivate func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(listenButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(XHMargin._10)
            make.left.equalTo(contentView).offset(XHMargin._15)
            make.bottom.equalTo(contentView).offset(-XHMargin._10)
            make.width.equalTo(80)
        }
        
        listenButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(contentView).offset(-XHMargin._15)
            make.width.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView).offset(XHMargin._10)
            make.left.equalTo(iconImageView.snp.right).offset(XHMargin._10)
            make.right.equalTo(listenButton.snp.left).offset(-XHMargin._10)
        }
    }
}
