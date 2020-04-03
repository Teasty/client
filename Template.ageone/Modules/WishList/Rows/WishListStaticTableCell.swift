//
//  Static.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 07/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class WishListStaticTableCell: BaseTableCell {

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

extension WishListStaticTableCell {
    
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
        log.info("Change cell inited")
        labelTitle.text = "Сдача с"
        labelDescription.text = ""
        labelState.text = rxData.order.value.change
        imageIcon.image = R.image.money()
        imageState.image = rxData.order.value.change == "Под расчёт" ? R.image.dropDown() : R.image.pointSelected()
    }
    
}

// MARK: Actions

extension WishListStaticTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        let actions: [AlertAction.ActionSheetElement] = [
            AlertAction.ActionSheetElement(name: "Под расчёт", value: "Под расчёт"),
            AlertAction.ActionSheetElement(name: "500 руб.", value: "500 руб."),
            AlertAction.ActionSheetElement(name: "1000 руб.", value: "1000 руб."),
            AlertAction.ActionSheetElement(name: "2000 руб.", value: "2000 руб."),
            AlertAction.ActionSheetElement(name: "5000 руб.", value: "5000 руб.")
        ]
        alertAction.actionSheet(title: "С какой суммы нужна сдача?", actions: actions, selected: rxData.order.value.change) { value in
            var order = rxData.order.value
            order.change = value
            rxData.order.accept(order)
        }
    }
}
