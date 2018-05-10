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

extension UIColor {
    struct QuestionHeaderView {
        static let titleLabel = UIColor(hexColor: "#777777")
    }
}

extension String {
    struct QuestionHeaderView {
        static let moreButtonImageName = "button_paperList_more"
    }
}

class XHQuestionHeaderView: UIView {
    
    weak var xh_delegate: XHQuestionHeaderViewDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
            if title == String.empty || title == nil {
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
            if text == String.empty {
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
        let pop = XHPopMenu(withButtonTitles: tempArray, tintColor: .darkGray, textColor: .white, buttonHeight: CGFloat.PopMenu.Height.popButton, textSize: CGFloat.FontSize._13)
        pop.xh_delegate = self
        return pop
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: UIColor.QuestionHeaderView.titleLabel, fontSize: CGFloat.FontSize._16)
        lbl.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._16)
        return lbl
    }()
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: String.QuestionHeaderView.moreButtonImageName), for: .normal)
        btn.addTarget(self, action: #selector(didClickMoreButtonAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.Global.lightGray
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
            make.top.equalTo(self).offset(XHMargin._10)
            make.left.equalTo(self).offset(XHMargin._15)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(self).offset(-XHMargin._15)
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

