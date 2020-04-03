//
//  CardRounded.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class CardRounded: BaseCollectionCell {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderContent()
        renderUI()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: viewInner
    
    fileprivate let viewInner: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12.0
        view.layer.borderWidth = 0.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.shadowOffset.height = 1.0
        view.backgroundColor = UIColor.white
        return view
    }()

    // MARK: imageBase
    
    fileprivate let imageBase: BaseImageView = {
        var imageView = BaseImageView()
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    // MARK: viewContent
    
    fileprivate let viewContent: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.0
        view.layer.borderWidth = 0.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = UIColor.white
        return view
    }()

    // MARK: viewDiscount
    
    fileprivate let viewDiscount: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12.0
        view.layer.borderWidth = 0.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = UIColor(hexString: "#FF3131") ?? UIColor()
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    // MARK: labelDiscount
    
    fileprivate let labelDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 14.0)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(hexString: "#FF3131") ?? UIColor()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 13.0)
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#979797") ?? UIColor()
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelPrice
    
    fileprivate let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#FF3131") ?? UIColor()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelPriceDiscount
    
    fileprivate let labelPriceDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#15CB8A") ?? UIColor()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: viewDiscountLine
    
    fileprivate let viewDiscountLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#15CB8A") ?? UIColor()
        return view
    }()
    
}

// MARK: renderUI

extension CardRounded {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: labelDiscount
        
        viewDiscount.addSubview(labelDiscount)
        labelDiscount.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: viewContent
        viewInner.addSubview(viewContent)
        viewContent.snp.makeConstraints { (make) in
            make.bottom.equalTo(-12)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: labelDescription
        
        viewContent.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(9)
            make.right.equalTo(-9)
        }
        
        // MARK: labelTitle

        viewContent.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelDescription.snp.top).offset(-4)
            make.left.equalTo(9)
            make.right.equalTo(-9)
        }

        // MARK: labelPrice

        viewContent.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelTitle.snp.top).offset(-4)
            make.left.equalTo(9)
            make.top.equalTo(8)
        }

        // MARK: labelPriceDiscount

        viewContent.addSubview(labelPriceDiscount)
        labelPriceDiscount.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelPrice.snp.centerY)
            make.right.equalTo(-9)
        }

        // MARK: viewDiscountLine

        viewInner.addSubview(viewDiscountLine)
        viewDiscountLine.snp.makeConstraints { (make) in
            make.left.equalTo(labelPriceDiscount.snp.left)
            make.right.equalTo(labelPriceDiscount.snp.right)
            make.centerY.equalTo(labelPriceDiscount.snp.centerY)
            make.height.equalTo(1)
        }
        
    }
    
    fileprivate func renderContent() {
        
        // MARK: viewInner
        
        contentView.addSubview(viewInner)
        viewInner.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(-16)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: imageBase
        
        viewInner.addSubview(imageBase)
        imageBase.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(-16)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: viewDiscount
        
        contentView.addSubview(viewDiscount)
        viewDiscount.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-8)
            make.width.equalTo(50)
            make.height.equalTo(28)
        }
    }
    
    // MARK: initialize
    
//    public func initialize(_ product: Product) {
//        labelDescription.text = "\(product.about)"
//        labelTitle.text = "\(product.name)"
//        if let image = product.image.first {
//            imageBase.loadImage(image.preview)
//        }
//        if product.discount > 0 {
//            let discount = product.price - (product.price * Double(product.discount) / 100)
//            viewDiscount.isHidden = false
//            labelDiscount.isHidden = false
//            labelPriceDiscount.isHidden = false
//            viewDiscountLine.isHidden = false
//            labelPrice.text = discount
//            labelPrice.textColor = utils.constants.colors.red
//            labelDiscount.text = "-\(product.discount)%"
//            labelPriceDiscount.text = basket.currencyConverter(price: product.price)
//        } else {
//            labelPrice.textColor = UIColor.black
//            labelPrice.text = basket.currencyConverter(price: product.price)
//            labelDiscount.text = ""
//            labelPriceDiscount.text = ""
//            viewDiscount.isHidden = true
//            labelDiscount.isHidden = true
//            labelPriceDiscount.isHidden = true
//            viewDiscountLine.isHidden = true
//        }
//    }
    
}

extension CardRounded {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
