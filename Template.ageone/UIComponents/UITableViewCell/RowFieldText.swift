//
//  RowTextField.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 01/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class RowFieldText: BaseTableCell {
    
    public var onTextEntered: ((String) -> Void)?
    
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
    
    public let textField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.defineType(MaterialTextField.Types.text)
        return textField
    }()
    
}

// MARK: Base methods

extension RowFieldText {
    
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
            self.onTextEntered?(text)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ text: String, _ placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
    }
    
}

// MARK: action

extension RowFieldText {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
       
    }
    
}
