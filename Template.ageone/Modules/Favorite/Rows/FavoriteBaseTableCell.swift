//
//  Base.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 02/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class FavoriteBaseTableCell: BaseTableCell {

    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 17.0)
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
    
    // MARK: buttonCanel
    
    public let buttonCanel: BaseButton = {
        let button = BaseButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(R.image.cancel(), for: UIControl.State.normal)
        button.imageView?.tintColor = UIColor.black
        button.layer.cornerRadius = 0.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()
}

// MARK: Base methods

extension FavoriteBaseTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: buttonCanel
        
        contentView.addSubview(buttonCanel)
        buttonCanel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(-20)
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        // MARK: labelTitle
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(20)
            make.right.equalTo(buttonCanel.snp.left).offset(-10)
        }
        
        // MARK: labelDescription
        
        contentView.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(8)
            make.bottom.equalTo(-16)
            make.left.equalTo(20)
            make.right.equalTo(buttonCanel.snp.left).offset(-10)
        }
        
    }
    
    // MARK: initialize

    public func initialize(_ title: String, _ description: String) {
        labelTitle.text = title
        labelDescription.text = description
    }
    
}

// MARK: Actions

extension FavoriteBaseTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
