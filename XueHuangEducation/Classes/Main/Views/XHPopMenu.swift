//
//  XHPopMenu.swift
//  XueHuangEducation
//
//  Created by tsaievan on 5/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

protocol XHPopMenuDelegate: NSObjectProtocol {
    func popMenuViewDidClickButton(menu: XHPopMenu, sender: UIButton)
}

class XHPopMenu: UIView {
    
    var lastButton: UIButton?
    
    weak var xh_delegate: XHPopMenuDelegate?
    
    init(withButtonTitles titles: [String], tintColor: UIColor, textColor: UIColor, buttonHeight: CGFloat, textSize: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: CGFloat(titles.count) * buttonHeight))
        backgroundColor = tintColor
        layer.cornerRadius = CGFloat.commonCornerRadius
        layer.masksToBounds = true
        for (index, title) in titles.enumerated() {
            let btn = UIButton(title: title, titleColor: textColor, fontSize: textSize, target: self, action: #selector(didClickPopMenuButton))
            btn.tag = index
            btn.titleLabel?.textAlignment = .center
            btn.sizeToFit()
            addSubview(btn)
            if index == 0 {
                btn.snp.makeConstraints({ (make) in
                    make.top.equalTo(self)
                    make.left.equalTo(self)
                    make.width.equalTo(self)
                    make.height.equalTo(buttonHeight)
                })
            }else {
                let seperatorView = UIView()
                seperatorView.backgroundColor = textColor
                addSubview(seperatorView)
                btn.snp.makeConstraints({ (make) in
                    make.top.equalTo(lastButton!.snp.bottom)
                    make.leading.equalTo(lastButton!)
                    make.width.equalTo(self)
                    make.height.equalTo(lastButton!)
                })
                seperatorView.snp.makeConstraints({ (make) in
                    make.left.equalTo(self).offset(XHMargin._5)
                    make.right.equalTo(self).offset(-XHMargin._5)
                    make.bottom.equalTo(btn.snp.top)
                    make.height.equalTo(0.5)
                })
            }
            lastButton = btn
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeFromSuperview()
    }
}

extension XHPopMenu {
    ///< 展示出来
    public func showRight(onView: UIView, atPoint: CGPoint) {
        frame = CGRect(x: atPoint.x - width, y: atPoint.y + XHMargin._10, width: frame.width, height: frame.height)
        onView.addSubview(self)
    }
    
    ///< 消失掉
    public func dismiss() {
        removeFromSuperview()
    }
}

// MARK: - 按钮的点击事件
extension XHPopMenu {
    @objc
    fileprivate func didClickPopMenuButton(sender: UIButton) {
        xh_delegate?.popMenuViewDidClickButton(menu: self, sender: sender)
    }
}
