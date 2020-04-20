//
//  WishListUpCostTableCell.swift
//  Template.ageone
//
//  Created by Андрей Лихачев on 09.04.2020.
//  Copyright © 2020 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class WishListUpCostTableCell: BaseTableCell {
    
    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: imageIcon
    
    fileprivate let imageIcon: BaseImageView = {
        let imageView = BaseImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: imageState
    
    fileprivate let imageState: BaseImageView = {
        let imageView = BaseImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: labelState
    
    fileprivate let labelState: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .right
        label.textColor = utils.constants.colors.darkGray
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 14.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.lightGray
        label.numberOfLines = 0
        return label
    }()
    
}

// MARK: Base methods

extension WishListUpCostTableCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: imageIcon
        
        contentView.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        // MARK: imageState
        
        contentView.addSubview(imageState)
        imageState.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(imageIcon.snp.centerY)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }
        
        // MARK: labelState
        
        contentView.addSubview(labelState)
        labelState.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.right.equalTo(imageState.snp.left).offset(-8)
            make.width.equalTo(100)
        }
        
        // MARK: labelTitle
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(imageIcon.snp.right).offset(8)
            make.right.equalTo(labelState.snp.left).offset(-8)
        }
        
        // MARK: labelDescription
        
        contentView.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalTo(-8)
            make.left.equalTo(labelTitle.snp.left)
            make.right.equalTo(-20)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize() {
        log.info("UpCost cell inited")
        labelTitle.text = "Увелечение стоимости"
        labelDescription.text = "Для более быстрой подачи автомобиля"
        labelState.text = rxData.order.value.upCost == 0 ? "Нет" : "\(String(rxData.order.value.upCost)) руб."
        imageIcon.image = R.image.money()
        imageState.image = rxData.order.value.upCost == 0 ? R.image.dropDown() : R.image.pointSelected()
    }
    
}

// MARK: Actions

extension WishListUpCostTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        let actions = [
            AlertAction.ActionSheetElement(name: "0 руб.", value: "0"),
            AlertAction.ActionSheetElement(name: "20 руб.", value: "20"),
            AlertAction.ActionSheetElement(name: "40 руб.", value: "40"),
            AlertAction.ActionSheetElement(name: "60 руб.", value: "60"),
            AlertAction.ActionSheetElement(name: "80 руб.", value: "80"),
            AlertAction.ActionSheetElement(name: "100 руб.", value: "100"),
            AlertAction.ActionSheetElement(name: "120 руб.", value: "120")
        ]
        alertAction.actionSheet(title: "На какую сумму увеличить ?", actions: actions, selected: "") { [unowned self] value in
            var order = rxData.order.value
            order.price = Double(value) ?? 0
            order.upCost = Int(value) ?? 0
            rxData.order.accept(order)
            
            api.request(["router": "upCost", "orderHashId": rxData.currentOrder?.hashId, "upCost": Double(value) ?? 0], completion: { _ in
                
            })
            
            api.requestPrice {
                
            }
        }
    }
}
