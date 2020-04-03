//
//  LoadingUILocker.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 23/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class LoadingUILocker {
    
    fileprivate let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
//        activity.style = UIActivityIndicatorView.Style.whiteLarge
        activity.color = UIColor.gray
        return activity
    }()

    fileprivate let visualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        let width = utils.variables.screenWidth
        let height = utils.variables.screenHeight
        visualEffectView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        visualEffectView.effect = UIBlurEffect(style: .light)
        visualEffectView.tag = 99999991
        visualEffectView.alpha = 0.6
        return visualEffectView
    }()
    
    // MARK: methods

    public func show(completion: @escaping () -> Void = {}) {
        utils.controller()?.view.endEditing(true)
        DispatchQueue.main.async { [unowned self] in
            if let window = UIApplication.shared.keyWindow {
                if window.viewWithTag(99999991) == nil {
                    window.addSubview(self.visualEffectView)
                    self.visualEffectView.snp.makeConstraints { (make) in
                        make.top.equalTo(0)
                        make.left.equalTo(0)
                        make.right.equalTo(0)
                        make.bottom.equalTo(0)
                    }
                    window.addSubview(self.activity)
                    self.activity.snp.makeConstraints { (make) in
                        make.centerX.equalTo(self.visualEffectView.snp.centerX)
                        make.centerY.equalTo(self.visualEffectView.snp.centerY)
                        make.width.equalTo(30)
                        make.height.equalTo(30)
                    }
                    UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                        self.visualEffectView.alpha = 1.0
                        self.activity.alpha = 1.0
                    })
                    self.activity.startAnimating()
                    completion()
                }
            }
        }
    }
    
    public func hide(completion: @escaping () -> Void = {}) {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.visualEffectView.alpha = 0.0
            self.activity.alpha = 0.0
        }, completion: { [unowned self] _ in
            self.visualEffectView.removeFromSuperview()
            self.activity.stopAnimating()
            self.activity.removeFromSuperview()
        })
    }
    
}
