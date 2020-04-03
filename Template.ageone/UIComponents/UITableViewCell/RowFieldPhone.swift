//
//  RowFieldPhone.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 03/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class RowFieldPhone: BaseTableCell {
    
    public var callback: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: textField
    
    fileprivate let textField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.defineType(MaterialTextField.Types.phone)
        return textField
    }()
    
}

// MARK: Base methods

extension RowFieldPhone {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: textField
        
        self.contentView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(-4)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40).priority(999)
        }
        textField.onTextEntered = { [unowned self] text in
            self.callback?(text)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ text: String, _ placeholder: String) {
        self.textField.text = text
        self.textField.placeholder = placeholder
    }
    
}

// MARK: action

extension RowFieldPhone {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        
    }
    
}
