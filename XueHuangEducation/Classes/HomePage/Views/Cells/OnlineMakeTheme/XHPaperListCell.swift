//
//  XHPaperListCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 4/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHPaperListCell: UITableViewCell {
    
    var model: XHPaperDetail? {
        didSet {
            guard let m = model,
            let title = m.name else {
                return
            }
            titleLabel.text = title + "(共\(m.Count ?? 0)题)"
        }
    }
    
    lazy var tipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_theme_filemark")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_GLOBAL_BLUE, fontSize: FONT_SIZE_13)
        lbl.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_13)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHPaperListCell {
    fileprivate func setupUI() {
        contentView.addSubview(tipImageView)
        contentView.addSubview(titleLabel)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_44)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_25)
        }
        
        tipImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel)
            make.right.equalTo(titleLabel.snp.left).offset(-MARGIN_GLOBAL_5)
        }
    }
}
