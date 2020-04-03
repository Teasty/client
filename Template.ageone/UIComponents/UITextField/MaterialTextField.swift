//
//  CETextField.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 23/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MaterialTextField: JVFloatLabeledTextField {
    
    public var onTap: (() -> Void)?
    public var onTextEntered: ((String) -> Void)?
    public var onFieldActivated: (() -> Void)?
    public var onAddressSelected: ((GoogleMapKit.Address) -> Void)?
    public var charLimit: Int? = nil
    
    public enum Types {
        case text
        case phone
        case sms
        case email
        case address
        case numbers
        case none
    }
    fileprivate var type = Types.text
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.render()
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    fileprivate let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hex("8E8E8E").withAlphaComponent(0.5)                                // bottom line
        return view
    }()
    
    // MARK: render
    
    fileprivate func render() {
        font = UIFont(name: utils.constants.font.regular, size: 17.0)
        textColor = UIColor.black.withAlphaComponent(0.87)
        placeholderColor = UIColor(hexString: "#737373") ?? UIColor()
        floatingLabelTextColor = UIColor(hexString: "#627FF2") ?? UIColor()
        floatingLabelFont = UIFont(name: utils.constants.font.regular, size: 12.0)
        floatingLabelActiveTextColor = UIColor(hexString: "#627FF2") ?? UIColor()
        backgroundColor = UIColor.clear
        returnKeyType = UIReturnKeyType.done
        keyboardType = UIKeyboardType.default
        autocorrectionType = .yes
        clearButtonMode = .whileEditing
        autocorrectionType = UITextAutocorrectionType.yes
        
        // MARK: Bottom line
        
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(4)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        }
        
    }
    
    public func defineType(_ type: MaterialTextField.Types) {
        self.type = type
        switch type {
        case .text: break
        case .phone:
            keyboardType = .decimalPad
        case .sms:
            keyboardType = UIKeyboardType.decimalPad
            textContentType = UITextContentType.oneTimeCode
        case .email:
            keyboardType = .emailAddress
        case .address: break
        case .none: break
        case .numbers:
            keyboardType = UIKeyboardType.numberPad
        }
    }
    
}

// MARK: Delegate

extension MaterialTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let text = self.text else { return false }
        
        if let limit = charLimit {
            if "\(text)\(string)".count > limit {
                return false
            }
        }
        
        switch type {
        case .text:
            onTextEntered?("\(text)\(string)")
            return true
        case .phone:
            if string.isEmpty {
                return true
            }
            if let text = self.text {
                var phone = utils.formatter.cleanPhonw("\(text)\(string)")
                if phone.count >= 11 {
                    phone = String(phone.prefix(11))
                }
                textField.text = utils.formatter.phone(phone)
                onTextEntered?("\(phone)")
            }
            return false
        case .sms:
            onTextEntered?("\(text)\(string)")
            return true
        case .email:
            onTextEntered?("\(text)\(string)")
            return true
        case .address:
            return false
        case .none:
            return false
        case .numbers:
            onTextEntered?("\(text)\(string)")
            return true
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        switch type {
        case .text:
            onTextEntered?("")
            return true
        case .phone:
            onTextEntered?("")
            return true
        case .sms:
            onTextEntered?("")
            return true
        case .email:
            onTextEntered?("")
            return true
        case .address:
            return false
        case .none:
            return false
        case .numbers:
            onTextEntered?("")
            return true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if let cell = textField.superview?.superview as? BaseTableCell {
            if let index = cell.indexPath {
                cell.tableView?.scrollToRow(at: index, at: .top, animated: true)
            }
        }
        
        onFieldActivated?()
        
        switch type {
        case .text:
            return true
        case .phone:
            return true
        case .sms:
            return true
        case .email:
            return true
        case .address:
            utils.googleMapKit.autocomplite { [unowned self] (address) in
                self.onAddressSelected?(address)
            }
            return false
        case .none:
            onTap?()
            return false
        case .numbers:
            return true
        }
    }
    
}
