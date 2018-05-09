//
//  XHLoadingView.swift
//  XueHuangEducation
//
//  Created by tsaievan on 8/5/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

let XHGlobalLoading = XHLoadingView.sharedView

class XHLoadingView: UIView {
    
    static let sharedView = XHLoadingView()
    
    lazy var loadingImageView: UIImageView = {
        let loading = UIImageView()
        loading.image = UIImage(named: "image_loading_global")
        loading.sizeToFit()
        loading.center = center
        return loading
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: GLOBAL_ZERO, y: GLOBAL_ZERO, width: WIDTH_GLOBAL_LOADING_VIEW, height: HEIGHT_GLOBAL_LOADING_VIEW))
        addSubview(loadingImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XHLoadingView {
    fileprivate func startAnimation() {
        loadingImageView.isHidden = false
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0.0
        animation.toValue = Double.pi * 2.0
        animation.duration = 1.0
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        loadingImageView.layer.add(animation, forKey: nil)
    }
    
    fileprivate func stopAnimation() {
        loadingImageView.isHidden = true
        loadingImageView.layer.removeAllAnimations()
    }
}

// MARK: - 提供两个类方法供外界调用
extension XHLoadingView {
    func startLoading() {
        ///< 防止子线程调用, 强行切到主线程来
        DispatchQueue.main.async {
            self.backgroundColor = .clear
            let backgroudView = XHLoadingBackgroundView(frame: XHSCreen.bounds)
            self.center = backgroudView.center
            backgroudView.addSubview(self)
            guard let delegate = UIApplication.shared.delegate,
                let window = delegate.window else {
                    return
            }
            window?.addSubview(backgroudView)
            self.startAnimation()
        }
    }
    
    func stopLoading() {
        ///< 防止子线程调用, 强行切到主线程来
        DispatchQueue.main.async {
            self.stopAnimation()
            self.superview?.removeFromSuperview()
        }
    }
}


class XHLoadingBackgroundView: UIView {
    ///< 默认可穿透
    var canPrick: Bool = true
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if canPrick {
            ///< 包含返回按钮所处的那个点, 则返回nil, 使点击事件穿透
            if CGRect(x: 0, y: 20, width: 32, height: 32).contains(point) && frame.height == XHSCreen.height {
                return nil
            }else {
                return super.hitTest(point, with: event)
            }
        }else {
            return super.hitTest(point, with: event)
        }
    }
}
