//
//  XHPaperSectionTitleView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 2/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

protocol XHPaperSectionTitleViewDelegate: NSObjectProtocol {
    func paperSectionTitleViewDidClickButtonList(sectionView: XHPaperSectionTitleView, sender: UIButton)
}

extension UIColor {
    struct PaperSectionTitleView {
        static let titleLabel = UIColor(hexColor: "#777777")
    }
}

extension CGFloat {
    struct PaperSectionTitleView {
        struct Height {
            static let headerView: CGFloat = 50
            static let seperatorView: CGFloat = 0.5
        }
    }
}

extension String {
    struct PaperSectionTitleView {
        static let moreButtonImageName = "button_paperList_more"
    }
}

fileprivate let headerViewHeight = CGFloat.PaperSectionTitleView.Height.headerView
fileprivate let seperatorViewHeight = CGFloat.PaperSectionTitleView.Height.seperatorView
fileprivate let popButtonHeight = CGFloat.PopMenu.Height.popButton

class XHPaperSectionTitleView: UITableViewHeaderFooterView {
    
    weak var xh_delegate: XHPaperSectionTitleViewDelegate?
    
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
        let pop = XHPopMenu(withButtonTitles: tempArray, tintColor: .darkGray, textColor: .white, buttonHeight: popButtonHeight, textSize: CGFloat.FontSize._13)
        pop.xh_delegate = self
        return pop
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(text: String.empty, textColor: UIColor.PaperSectionTitleView.titleLabel, fontSize: CGFloat.FontSize._16)
        lbl.font = UIFont.boldSystemFont(ofSize: CGFloat.FontSize._16)
        return lbl
    }()
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: String.PaperSectionTitleView.moreButtonImageName), for: .normal)
        btn.addTarget(self, action: #selector(didClickMoreButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.Global.lightGray
        return v
    }()
    
    lazy var headerView: XHTeachSectionHeaderView = {
        let header = XHTeachSectionHeaderView()
        return header
    }()
    
    ///< 这里的数据赋值表示是从首页进来的
    var info: (model: XHCourseCatalog, text: String?)?{
        didSet {
            guard let modelInfo = info else {
                return
            }
            headerView.model = modelInfo.model
            titleLabel.text = modelInfo.text
        }
    }
    
    var buttonModels: [XHCourseCatalog]?
    
    var newInfo: (catalogs: XHCourseCatalog?, paperList: XHPaperList?)? {
        didSet {
            guard let modelInfo = newInfo else {
                return
            }
            headerView.model = modelInfo.catalogs
            guard let paperL = modelInfo.paperList else {
                return
            }
            if let titleText = paperL.courseClassName {
                titleLabel.text = titleText
            }
            if let paperL = modelInfo.paperList {
                buttonModels = paperL.sCourseCatalogs
            }
        }
    }
    
    var sectionTitle: String? {
        didSet {
            guard let text = sectionTitle else {
                return
            }
            titleLabel.text = text
        }
    }
    
    
    var tapSectionClosure: XHTapTeachSectionHeaderView? {
        didSet {
            headerView.tapSectionClosure = tapSectionClosure
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHPaperSectionTitleView {
    fileprivate func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(seperatorView)
        contentView.addSubview(headerView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(XHMargin._10)
            make.left.equalTo(contentView).offset(XHMargin._15)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(contentView).offset(-XHMargin._15)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView)
            make.height.equalTo(seperatorViewHeight)
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(XHMargin._10)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView.snp.bottom)
            make.left.right.equalTo(contentView)
            make.height.equalTo(headerViewHeight).priority(.low)
        }
    }
}


// MARK: - 更多按钮点击事件
extension XHPaperSectionTitleView {
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

// MARK: - popMenu的代理方法
extension XHPaperSectionTitleView: XHPopMenuDelegate {
    func popMenuViewDidClickButton(menu: XHPopMenu, sender: UIButton) {
        xh_delegate?.paperSectionTitleViewDidClickButtonList(sectionView: self, sender: sender)
    }
}

// MARK: - 其他事件
extension XHPaperSectionTitleView {
    func dismissPopMenuView() {
        moreButton.isSelected = false
        popView?.dismiss()
    }
}

