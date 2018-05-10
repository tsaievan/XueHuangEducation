//
//  XHSectionTitleHeaderView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 1/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

// MARK: - XHSectionTitleHeaderView代理
protocol XHSectionTitleHeaderViewDelegate: NSObjectProtocol {
    func sectionTitleHeaderViewDidClickButtonList(headerView: XHSectionTitleHeaderView, sender: UIButton)
}

extension String {
    struct SectionTitleHeaderView {
        static let titleButtonText = " 讲题列表"
        static let titleButtonImageName = "catalogList_listen_small_button"
        static let moreButtonImageName = "button_paperList_more"
    }
}

class XHSectionTitleHeaderView: UITableViewHeaderFooterView {
    
    weak var xh_delegate: XHSectionTitleHeaderViewDelegate?
    
    // MARK: - 懒加载
    lazy var titleButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: String.SectionTitleHeaderView.titleButtonImageName), for: .normal)
        btn.setTitle(String.SectionTitleHeaderView.titleButtonText, for: .normal)
        btn.setTitleColor(COLOR_PAPAER_TYPE_BUTTON_TITLE, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: FONT_SIZE_16)
        btn.sizeToFit()
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
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: String.SectionTitleHeaderView.moreButtonImageName), for: .normal)
        btn.addTarget(self, action: #selector(didClickMoreButtonAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    var buttonModels: [XHCourseCatalog]?
    
    var info: (catalogs: XHCourseCatalog?, themeList: XHThemeList?)? {
        didSet {
            guard let modelInfo = info else {
                return
            }
            headerView.model = modelInfo.catalogs
            if let titleText = modelInfo.themeList?.courseClassName {
                titleButton.setTitle(" \(titleText)", for: .normal)
            }
            if let themeL = modelInfo.themeList {
                buttonModels = themeL.sCourseCatalogs
                moreButton.isHidden = false
            }else {
                moreButton.isHidden = true
            }
        }
    }
    
    var tapSectionClosure: XHTapTeachSectionHeaderView? {
        didSet {
            headerView.tapSectionClosure = tapSectionClosure
        }
    }
    // MARK: - init方法
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension XHSectionTitleHeaderView {
    fileprivate func setupUI() {
        contentView.addSubview(titleButton)
        contentView.addSubview(moreButton)
        contentView.addSubview(seperatorView)
        contentView.addSubview(headerView)
        makeConstraints()
    }
    
    fileprivate func makeConstraints() {
        titleButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(MARGIN_GLOBAL_10)
            make.left.equalTo(contentView).offset(MARGIN_GLOBAL_15)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView)
            make.height.equalTo(0.5)
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(titleButton.snp.bottom).offset(MARGIN_GLOBAL_10)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView.snp.bottom)
            make.left.right.equalTo(contentView)
            make.height.equalTo(50).priority(.low)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleButton)
            make.right.equalTo(contentView).offset(-MARGIN_GLOBAL_15)
        }
    }
}

// MARK: - 按钮点击事件
extension XHSectionTitleHeaderView {
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

// MARK: - 其他方法
extension XHSectionTitleHeaderView {
    func dismissPopMenuView() {
        moreButton.isSelected = false
        popView?.dismiss()
    }
}

// MARK: - PopMenu的代理方法
extension XHSectionTitleHeaderView: XHPopMenuDelegate {
    func popMenuViewDidClickButton(menu: XHPopMenu, sender: UIButton) {
        xh_delegate?.sectionTitleHeaderViewDidClickButtonList(headerView: self, sender: sender)
    }
}
