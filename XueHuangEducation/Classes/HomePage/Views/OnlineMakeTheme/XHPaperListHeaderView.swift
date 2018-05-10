//
//  XHPaperListHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 4/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

extension UIColor {
    struct PaperListHeaderView {
        static let seperator = UIColor(hexColor: "#EEEEEE")
        static let titleLabel = UIColor(hexColor: "#777777")
    }
}

extension CGFloat {
    struct PaperListHeaderView {
        struct Height {
            static let seperatorView: CGFloat = 0.5
        }
    }
}

fileprivate let seperatorViewHeight = CGFloat.PaperListHeaderView.Height.seperatorView

class XHPaperListHeaderView: UIView {
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "image_theme_paperList")
        v.sizeToFit()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: UIColor.PaperListHeaderView.titleLabel, fontSize: CGFloat.FontSize._16)
        lbl.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._16)
        return lbl
    }()
    
    lazy var seperatorView: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor.PaperListHeaderView.seperator
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHPaperListHeaderView {
    fileprivate func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(seperatorView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(XHMargin._20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(XHMargin._10)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView)
            make.bottom.equalTo(self).offset(-XHMargin._0_5)
            make.right.equalTo(self)
            make.height.equalTo(seperatorViewHeight)
        }
    }
}


