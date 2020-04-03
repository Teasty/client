//
//  MapSearchingView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 05/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class MapSearchingView: BaseView {
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.35)
        isHidden = true
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activity.style = UIActivityIndicatorView.Style.whiteLarge
        activity.color = UIColor.white
        return activity
    }()
    
    // MARK: labelCancel
    
    fileprivate let labelCancel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 14.0)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = "Отменить\nпоездку"
        return label
    }()
    
    // MARK: buttonCancel
    
    public let buttonCancel: BaseButton = {
        let button = BaseButton()
        button.setImage(R.image.buttonCancel(), for: UIControl.State.normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 0.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    public func show() {
        isHidden = false
        activity.startAnimating()
    }
    
    public func hide() {
        isHidden = true
        activity.stopAnimating()
    }
    
    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 22.0)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = "Подождите немного, мы подбираем для Вас водителя"
        return label
    }()
}

extension MapSearchingView {
 
    fileprivate func renderUI() {
        
        // MARK: labelCancel
        
        addSubview(labelCancel)
        labelCancel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        // MARK: buttonCancel
        
        addSubview(buttonCancel)
        buttonCancel.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelCancel.snp.top).offset(0)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(63)
            make.height.equalTo(63)
        }
        
        // MARK: activity
        
        addSubview(activity)
        activity.snp.makeConstraints { (make) in
            make.bottom.equalTo(buttonCancel.snp.top).offset(-30)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        // MARK: labelDescription
        
        addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.bottom.equalTo(activity.snp.top).offset(-25)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(250)
        }
        
    }
    
}
