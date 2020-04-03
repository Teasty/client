//
//  MapTariffsCollectionCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class MapTariffsCollectionCell: BaseCollectionCell {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
        viewInner.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        viewShadow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: labelPrice
    
    fileprivate let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 13.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelName
    
    fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 14.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: imageIcon
    
    fileprivate let imageIcon: BaseImageView = {
        var imageView = BaseImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    // MARK: viewInner
    
    fileprivate let viewInner: BaseView = {
        let view = BaseView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10.0
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOffset.height = 2.0
        return view
    }()
    
    // MARK: viewShadow
    
    fileprivate let viewShadow: BaseView = {
        let view = BaseView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 12.0
        return view
    }()
    
}

// MARK: renderUI

extension MapTariffsCollectionCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: viewInner
        
        contentView.addSubview(viewInner)
        viewInner.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(-7)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        
        // MARK: labelPrice
        
        viewInner.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { (make) in
            make.bottom.equalTo(-6)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: labelName
        
        viewInner.addSubview(labelName)
        labelName.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelPrice.snp.top).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: imageIcon
        
        viewInner.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelName.snp.top).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(22)
        }
        
        // MARK: viewShadow
        
        viewInner.addSubview(viewShadow)
        viewShadow.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ tariff: Tariff) {
        labelPrice.text = tariff.info
        labelName.text = tariff.name
        imageIcon.loadImage(tariff.image?.original)
        if rxData.order.value.tariff.hashId == tariff.hashId {
            viewShadow.isHidden = true
        } else {
            viewShadow.isHidden = false
        }
    }
    
}

extension MapTariffsCollectionCell {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
