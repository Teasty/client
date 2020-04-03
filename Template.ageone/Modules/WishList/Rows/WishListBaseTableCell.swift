//
//  Base.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 06/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class WishListBaseTableCell: BaseTableCell {
    
    public var onTap: (() -> Void)?
    fileprivate var wishList = WishList()
    
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

extension WishListBaseTableCell {
    
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
    
    public func initialize(_ wishList: WishList) {
        self.wishList = wishList
        labelTitle.text = wishList.name
        imageIcon.image = R.image.money()
        switch WishListType(rawValue: wishList.__type) {
        case .some(.single):
            imageState.image = R.image.point()
            labelState.text = ""
            if let selected = rxData.order.value.options.filter({$0.key == wishList}).first {
                if selected.value == wishList.singleValue {
                    imageState.image = R.image.pointSelected()
                    labelState.text = selected.value.name
                }
            }
        case .some(.dropdown):
            imageState.image = R.image.dropDown()
            labelState.text = ""
            //            log.info(rxData.order.value.options)
            if let selected = rxData.order.value.options.filter({$0.key == wishList}).first {
                if wishList.multipleValue.contains(selected.value) {
                    imageState.image = R.image.pointSelected()
                    labelState.text = selected.value.name
                    log.info(selected)
                }
            }
        case .none: break
        }
    }
    
}

// MARK: Actions

extension WishListBaseTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        switch WishListType(rawValue: wishList.__type) {
        case .some(.single):
            var order = rxData.order.value
            if let selected = rxData.order.value.options.filter({$0.key == wishList}).first {
                if selected.value == wishList.singleValue {
                    order.options[wishList] = WishListValue()
                } else {
                    order.options[wishList] = wishList.singleValue
                }
            } else {
                order.options[wishList] = wishList.singleValue
            }
            rxData.order.accept(order)
            api.requestPrice { }
        case .some(.dropdown):
            var actions: [AlertAction.ActionSheetElement] = []
            for wish in wishList.multipleValue.sorted(by: { (w1, w2) -> Bool in
                w2.price > w1.price
            }) {
                actions.append(AlertAction.ActionSheetElement(name: wish.name, value: "\(wish.hashId)"))
            }
            actions.append(AlertAction.ActionSheetElement(name: "Без дополнений", value: "0"))
            let selected = rxData.order.value.options.filter({$0.key == wishList}).first?.value.name ?? ""
            alertAction.actionSheet(title: "Выберите", actions: actions, selected: selected) { [unowned self] value in
                if let wish = utils.realm.wishlistvalue.getObjectsById(value) {
                    var order = rxData.order.value
                    order.options[self.wishList] = wish
                    rxData.order.accept(order)
                    api.requestPrice { }
                }
                if value == "0" {
                    var order = rxData.order.value
                    order.options.removeValue(forKey: self.wishList)
                    rxData.order.accept(order)
                    api.requestPrice { }
                }
            }
        case .none: break
        }
        onTap?()
    }
}
