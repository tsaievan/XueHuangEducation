//
//  XHQuestionHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 3/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

protocol XHQuestionHeaderViewDelegate: NSObjectProtocol {
    func questionHeaderViewDidClickButtonList(sectionView: XHQuestionHeaderView, sender: UIButton)
}

class XHQuestionHeaderView: UIView {
    
    weak var xh_delegate: XHQuestionHeaderViewDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
            if title == "" || title == nil {
                moreButton.isHidden = true
            }else {
                moreButton.isHidden = false
            }
        }
    }
    
    var newInfo: XHQuestionList? {
        didSet {
            guard let info = newInfo else {
                return
            }
            buttonModels = info.sCourseCatalogs
            titleLabel.text = info.courseClassName
            guard let text = titleLabel.text else {
                moreButton.isHidden = true
                return
            }
            if text == "" {
                moreButton.isHidden = true
            }else {
                moreButton.isHidden = false
            }
        }
    }
    
    var buttonModels: [XHCourseCatalog]?
    
    lazy var popView: XHPopMenu? = {
        guard let models = buttonModels else {
            return nil
        }
        var tempArray = [String]()
        for model in models {
            guard let name = model.courseClassName else {
                continue
            }
            tempArray.append(name)
        }
        let pop = XHPopMenu(withButtonTitles: tempArray, tintColor: .darkGray, textColor: .white, buttonHeight: 40, textSize: 13)
        pop.xh_delegate = self
        return pop
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: "", textColor: COLOR_PAPAER_TYPE_BUTTON_TITLE, fontSize: FONT_SIZE_16)
        lbl.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_16)
        return lbl
    }()
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "button_paperList_more"), for: .normal)
        btn.addTarget(self, action: #selector(didClickMoreButtonAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = COLOR_CLOBAL_LIGHT_GRAY
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHQuestionHeaderView {
    fileprivate func setupUI() {
        addSubview(titleLabel)
        addSubview(moreButton)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(self).offset(MARGIN_GLOBAL_15)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(self).offset(-MARGIN_GLOBAL_15)
        }
    }
}

// MARK: - 按钮的点击事件
extension XHQuestionHeaderView {
    ///< 更多按钮的点击事件
    @objc
    fileprivate func didClickMoreButtonAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let point = convert(moreButton.center, to: superview)
        guard let pView = popView else {
            return
        }
        sender.isSelected ? pView.showRight(onView: superview!, atPoint: point) : pView.dismiss()
    }
}

// MARK: - popMenuView的代理方法
extension XHQuestionHeaderView: XHPopMenuDelegate {
    func popMenuViewDidClickButton(menu: XHPopMenu, sender: UIButton) {
        xh_delegate?.questionHeaderViewDidClickButtonList(sectionView: self, sender: sender)
    }
}


extension XHQuestionHeaderView {
    func dismissPopMenuView() {
        moreButton.isSelected = false
        popView?.dismiss()
    }
}

