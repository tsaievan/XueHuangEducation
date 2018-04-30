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
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_CATALOG_BUTTON_TITLE_COLOR, fontSize: FONT_SIZE_16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var listenButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "catalogList_listen_button"), for: .normal)
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
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
            make.bottom.equalTo(contentView).offset(-MARGIN_GLOBAL_10)
            make.width.equalTo(80)
        }
        
        listenButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_15)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(iconImageView.snp.right).offset(MARGIN_GLOBAL_10)
            make.right.equalTo(listenButton.snp.left).offset(-MARGIN_GLOBAL_10)
        }
    }
}
