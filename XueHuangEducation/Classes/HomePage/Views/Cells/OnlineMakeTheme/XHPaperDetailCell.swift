//
//  XHPaperDetailCell.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIColor {
    struct PaperDetailCellContentView {
        static let titleLabel = UIColor(hexColor: "#777777")
        static let practiceButton_normal = UIColor(hexColor: "#777777")
    }
}

extension String {
    struct PaperDetailCellContentView {
        static let practiceButtonImageName = "button_paperList_practice"
        static let iconImageName = "image_paperList_practice"
    }
}

extension CGFloat {
    struct PaperDetailCellContentView {
        struct Height {
            static let seperatorView: CGFloat = 0.5
        }
    }
}

fileprivate let practiceButtonImageName = String.PaperDetailCellContentView.practiceButtonImageName
fileprivate let iconImageName = String.PaperDetailCellContentView.iconImageName
fileprivate let seperatorViewHeight = CGFloat.PaperDetailCellContentView.Height.seperatorView

class XHPaperDetailCellContentView: UIView {
    lazy var practiceButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: practiceButtonImageName), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._13)
        return btn
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.Global.lightGray
        return v
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: iconImageName)
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: UIColor.PaperDetailCellContentView.titleLabel, fontSize: CGFloat.FontSize._13)
        lbl.numberOfLines = Int.zero
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
            practiceButton.setTitleColor(UIColor.PaperDetailCellContentView.practiceButton_normal, for: .normal)
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
            make.top.equalTo(self).offset(XHMargin._5)
            make.left.equalTo(self).offset(XHMargin._15)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.top.equalTo(practiceButton.snp.bottom).offset(XHMargin._5)
            make.left.equalTo(self).offset(XHMargin._15)
            make.right.equalTo(self).offset(-XHMargin._15)
            make.height.equalTo(seperatorViewHeight)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView.snp.bottom).offset(XHMargin._5)
            make.left.equalTo(self).offset(XHMargin._15)
            make.bottom.equalTo(self).offset(-XHMargin._10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView).offset(XHMargin._10)
            make.left.equalTo(iconImageView.snp.right).offset(XHMargin._10)
        }
    }
}

class XHPaperDetailCell: UITableViewCell {
    
    lazy var container: XHPaperDetailCellContentView = {
        let cv = XHPaperDetailCellContentView()
        cv.layer.cornerRadius = CGFloat.commonCornerRadius
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
            make.top.equalTo(contentView).offset(XHMargin._5)
            make.left.equalTo(contentView).offset(XHMargin._10)
            make.bottom.equalTo(contentView).offset(-XHMargin._5)
            make.right.equalTo(contentView).offset(-XHMargin._10)
        }
    }
}
