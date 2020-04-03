//
//  Base.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class LostedBaseTableCell: BaseTableCell {

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
    
    // MARK: labelText
    
    fileprivate let labelText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 16.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = "Что-то забыли в такси?\nВ будние дни с  09.00. до 17.00.\nОбед с 13.00 до 14.00"
        return label
    }()
    
    // MARK: buttonPhone
    
    public let buttonPhone: BaseButton = {
        let button = BaseButton()
        button.setTitle("+7 (8182) 27 52 70", for: UIControl.State.normal)
        button.setTitleColor(UIColor(hexString: "#007AFF") ?? UIColor(), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: utils.constants.font.bold, size: 14.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        button.layer.cornerRadius = 0.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()
    
}

// MARK: Base methods

extension LostedBaseTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: labelText
        
        contentView.addSubview(labelText)
        labelText.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        // MARK: buttonPhone
        
        contentView.addSubview(buttonPhone)
        buttonPhone.snp.makeConstraints { (make) in
            make.top.equalTo(labelText.snp.bottom).offset(9)
            make.bottom.equalTo(-20)
            make.left.equalTo(14)
            make.width.equalTo(130)
        }
        
    }
    
    // MARK: initialize

    public func initialize() {
        
    }
    
}

// MARK: Actions

extension LostedBaseTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
