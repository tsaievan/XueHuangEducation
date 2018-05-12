//
//  XHProfileTableView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 12/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class XHProfileTableView: XHTableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        backgroundColor = UIColor.Global.background
        tableFooterView = UIView()
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
