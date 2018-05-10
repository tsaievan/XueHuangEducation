//
//  XHButton.swift
//  XueHuangEducation
//
//  Created by tsaievan on 29/4/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

///< 简单封装一个自定义的button
class XHButton: UIControl {
    
    var imageView: UIImageView?
    
    var titleLabel: UILabel?
    
    init(withButtonImage: String?, title: String?, titleColor: UIColor = .darkGray, titleFont: CGFloat = 17, gap: CGFloat = 5) {
        super.init(frame: .zero)
        if let imageName = withButtonImage {
            imageView = UIImageView()
            imageView?.image = UIImage(named: imageName)
            imageView?.contentMode = .scaleAspectFit
            addSubview(imageView!)
            imageView?.snp.makeConstraints({ (make) in
                make.top.left.equalTo(self).offset(XHMargin._5)
                make.right.equalTo(self).offset(-XHMargin._5)
            })
        }
        
        if let text = title {
            titleLabel = UILabel(text: text, textColor: titleColor, fontSize: titleFont)
            titleLabel?.textAlignment = .center
            addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints({ (make) in
                make.top.equalTo((imageView == nil ? self : imageView!.snp.bottom)).offset(gap)
                make.left.right.equalTo(self)
            })
        }
        if imageView == nil && titleLabel != nil {
            self.snp.makeConstraints { (make) in
                make.bottom.equalTo(titleLabel!.snp.bottom).priority(.low)
            }
        }
        if imageView != nil && titleLabel == nil {
            self.snp.makeConstraints({ (make) in
                make.bottom.equalTo(imageView!.snp.bottom).priority(.low)
            })
        }
        if  imageView != nil && titleLabel != nil {
            self.snp.makeConstraints({ (make) in
                make.bottom.equalTo(titleLabel!.snp.bottom).priority(.low)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

