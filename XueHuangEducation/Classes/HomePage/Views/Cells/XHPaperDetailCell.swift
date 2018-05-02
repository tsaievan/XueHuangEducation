//
//  XHPaperDetailCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHPaperDetailCellContentView: UIView {
    lazy var practiceButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "button_paperList_practice"), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_13)
        return btn
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = COLOR_CLOBAL_LIGHT_GRAY
        return v
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_paperList_practice")
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_PAPAER_TYPE_BUTTON_TITLE, fontSize: FONT_SIZE_13)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var info: XHPaper? {
        didSet {
            guard let model = info,
                let buttonTitle = model.typeName,
                let labelText = model.paperName else {
                    return
            }
            practiceButton.setTitle(buttonTitle, for: .normal)
            practiceButton.setTitleColor(COLOR_PAPAER_TYPE_BUTTON_TITLE, for: .normal)
            titleLabel.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHPaperDetailCellContentView {
    fileprivate func setupUI() {
        backgroundColor = COLOR_PAPER_CELL_LIGHT_GRAY
        addSubview(practiceButton)
        addSubview(seperatorView)
        addSubview(iconImageView)
        addSubview(titleLabel)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        practiceButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(MARGIN_GLOBAL_5)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_15)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.top.equalTo(practiceButton.snp.bottom).offset(MARGIN_GLOBAL_5)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_15)
            make.right.equalTo(self).offset(-MARGIN_GLOBAL_15)
            make.height.equalTo(0.5)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView.snp.bottom).offset(MARGIN_GLOBAL_5)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_15)
            make.bottom.equalTo(self).offset(-MARGIN_GLOBAL_10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(iconImageView.snp.right).offset(MARGIN_GLOBAL_10)
        }
    }
}

class XHPaperDetailCell: UITableViewCell {
    
    lazy var container: XHPaperDetailCellContentView = {
        let cv = XHPaperDetailCellContentView()
        cv.layer.cornerRadius = 5
        cv.layer.masksToBounds = true
        return cv
    }()
    
    var info: XHPaper? {
        didSet {
            container.info = info
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

extension XHPaperDetailCell {
    fileprivate func setupUI() {
        contentView.addSubview(container)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        container.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_5)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.bottom.equalTo(contentView).offset(-MARGIN_GLOBAL_5)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_10)
        }
    }
}
