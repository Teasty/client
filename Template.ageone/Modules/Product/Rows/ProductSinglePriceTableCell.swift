//
//  Price.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 05/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class ProductPriceTableCell: BaseTableCell {

    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: imageIcon
    
    fileprivate let imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.singlePack()
        return imageView
    }()
    
    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 9.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.gray
        label.numberOfLines = 1
        label.text = ProductViewModel.Localization.singlePackDescription
        return label
    }()
    
    // MARK: labelPrice
    
    fileprivate let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 20.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelDiscount
    
    fileprivate let labelDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 20.0)
        label.textAlignment = .right
        label.textColor = utils.constants.colors.red
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelPriceWithoutDiscount
    
    fileprivate let labelPriceWithoutDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 13.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.red
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: imagePackIcon
    
    fileprivate let imagePackIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.multiPack()
        return imageView
    }()
    
    // MARK: labelPackDescription
    
    fileprivate let labelPackDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 9.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.gray
        label.numberOfLines = 1
        label.text = ProductViewModel.Localization.multiPackDescription
        return label
    }()
    
    // MARK: labelPackPrice
    
    fileprivate let labelPackPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 20.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelPackDiscount
    
    fileprivate let labelPackDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 20.0)
        label.textAlignment = .right
        label.textColor = utils.constants.colors.red
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelPackPriceWithoutDiscount
    
    fileprivate let labelPackPriceWithoutDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 13.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.red
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelPackBadge
    
    let labelPackBadge: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 9.0)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.text = "12"
        label.backgroundColor = utils.constants.colors.red
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 10.0
        label.clipsToBounds = true
        return label
    }()
}

// MARK: Base methods

extension ProductPriceTableCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: imageIcon
        
        self.contentView.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(28)
            make.height.equalTo(20)
            make.width.equalTo(19)
        }
        
        // MARK: labelDescription
        
        self.contentView.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(imageIcon.snp.bottom).offset(0)
            make.centerX.equalTo(imageIcon.snp.centerX)
        }
        
        // MARK: labelDiscount
        
        self.contentView.addSubview(labelDiscount)
        labelDiscount.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(imageIcon.snp.centerY)
        }
        
        // MARK: labelPrice
        
        self.contentView.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(imageIcon.snp.right).offset(22)
            make.right.equalTo(labelDiscount.snp.left).offset(-12)
        }
        
        // MARK: labelPriceWithoutDiscount
        
        self.contentView.addSubview(labelPriceWithoutDiscount)
        labelPriceWithoutDiscount.snp.makeConstraints { (make) in
            make.top.equalTo(labelPrice.snp.bottom).offset(0)
//            make.bottom.equalTo(-16)
            make.left.equalTo(imageIcon.snp.right).offset(22)
            make.right.equalTo(labelDiscount.snp.left).offset(-12)
        }
        
        // MARK: imagePackIcon
        
        self.contentView.addSubview(imagePackIcon)
        imagePackIcon.snp.makeConstraints { (make) in
            make.top.equalTo(labelDescription.snp.bottom).offset(20)
            make.left.equalTo(28)
            make.height.equalTo(20)
            make.width.equalTo(19)
        }
        
        // MARK: labelPackDescription
        
        self.contentView.addSubview(labelPackDescription)
        labelPackDescription.snp.makeConstraints { (make) in
            make.top.equalTo(imagePackIcon.snp.bottom).offset(0)
            make.centerX.equalTo(imageIcon.snp.centerX)
        }
        
        // MARK: labelPackDiscount
        
        self.contentView.addSubview(labelPackDiscount)
        labelPackDiscount.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(imagePackIcon.snp.centerY)
        }
        
        // MARK: labelPackPrice
        
        self.contentView.addSubview(labelPackPrice)
        labelPackPrice.snp.makeConstraints { (make) in
            make.top.equalTo(labelDescription.snp.bottom).offset(13)
            make.left.equalTo(imagePackIcon.snp.right).offset(22)
            make.right.equalTo(labelPackDiscount.snp.left).offset(-12)
        }
        
        // MARK: labelPackPriceWithoutDiscount
        
        self.contentView.addSubview(labelPackPriceWithoutDiscount)
        labelPackPriceWithoutDiscount.snp.makeConstraints { (make) in
            make.top.equalTo(labelPackPrice.snp.bottom).offset(0)
            make.bottom.equalTo(-16)
            make.left.equalTo(imagePackIcon.snp.right).offset(22)
            make.right.equalTo(labelPackDiscount.snp.left).offset(-12)
        }
        
        // MARK: labelPackBadge
        
        self.contentView.addSubview(labelPackBadge)
        labelPackBadge.snp.makeConstraints { (make) in
            make.top.equalTo(imagePackIcon.snp.top).offset(-8)
            make.centerX.equalTo(imagePackIcon.snp.right).offset(4)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }

    }
    
    // MARK: initialize

    public func initialize(_ product: Product) {
        labelPackPrice.text = "90 руб."
        labelPackDiscount.text = "- 15%"
        labelPackPriceWithoutDiscount.text = "без скидки 1140.00 руб."
        if product.discount > 0 {
            let discount = product.price - (product.price * Double(product.discount) / 100)
            labelDiscount.isHidden = false
            labelPriceWithoutDiscount.isHidden = false
            labelPrice.text = basket.currencyConverter(price: discount)
            labelDiscount.text = "- \(product.discount)%"
            labelPriceWithoutDiscount.text = "\(ProductViewModel.Localization.priceWithoutDescount) \(basket.currencyConverter(price: product.price))"
            labelPrice.snp.updateConstraints { (upd) in
                upd.top.equalTo(0)
            }
        } else {
            labelDiscount.isHidden = true
            labelPriceWithoutDiscount.isHidden = true
            labelPrice.text = basket.currencyConverter(price: product.price)
            labelDiscount.text = " "
            labelPriceWithoutDiscount.text = ""
            labelPrice.snp.updateConstraints { (upd) in
                upd.top.equalTo(8)
            }
        }
    }
    
}

// MARK: Actions

extension ProductPriceTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
