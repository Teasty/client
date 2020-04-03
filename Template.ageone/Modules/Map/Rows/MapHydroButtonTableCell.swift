//
//  HydroButton.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class MapHydroButtonTableCell: BaseTableCell {

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
    
    public let button: ShadowButton = {
        let button = ShadowButton()
        return button
    }()
    
    // MARK: labelPrice
    
    fileprivate let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 19.0)
        label.textAlignment = .center
        label.textColor = utils.constants.colors.darkBlue
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelOrder
    
    fileprivate let labelOrder: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 19.0)
        label.textAlignment = .center
        label.textColor = utils.constants.colors.darkBlue
        label.numberOfLines = 1
        label.text = "Заказать"
        return label
    }()
    
    // MARK: viewDivider
    
    fileprivate let viewDivider: BaseView = {
        let view = BaseView()
        view.backgroundColor = utils.constants.colors.darkBlue
        return view
    }()
    
}

// MARK: Base methods

extension MapHydroButtonTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: GradientButton
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(56).priority(999)
        }
        
        // MARK: labelPrice
        
        button.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(button.snp.centerX)
        }
        
        // MARK: labelOrder
        
        button.addSubview(labelOrder)
        labelOrder.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
            make.left.equalTo(labelPrice.snp.right)
        }
        
        // MARK: viewDivider
        
        button.addSubview(viewDivider)
        viewDivider.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.centerX.equalTo(button.snp.centerX)
            make.width.equalTo(1)
        }
        
    }
    
    // MARK: initialize

    public func initialize(_ text: String) {
        labelPrice.text = text
    }
    
}

// MARK: Actions

extension MapHydroButtonTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
