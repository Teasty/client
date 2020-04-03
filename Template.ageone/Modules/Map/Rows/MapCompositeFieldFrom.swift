//
//  RowCompositeField.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class MapCompositeFieldFrom: BaseTableCell {
    
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
    
    // MARK: textField
    
    public let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: utils.constants.font.regular, size: 17.0)
        textField.textColor = utils.constants.colors.darkGray
        return textField
    }()
    
    // MARK: buttonLeft
    
    public let buttonLeft: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 0.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    // MARK: buttonRight
    
    public let buttonRight: BaseButton = {
        let button = BaseButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 0.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    // MARK: viewLine
    
    fileprivate let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        view.layer.cornerRadius = 0.0
        return view
    }()
    
    // MARK: labelAccurancy
    
    fileprivate let labelAccurancy: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 12.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.darkGray
        label.numberOfLines = 1
        return label
    }()
    
}

// MARK: Base methods

extension MapCompositeFieldFrom {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: textField
        
        contentView.addSubview(textField)
        textField.delegate = self
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(48)
            make.right.equalTo(-48)
            make.height.equalTo(40).priority(999)
        }
        
        // MARK: buttonLeft
        
        contentView.addSubview(buttonLeft)
        buttonLeft.snp.makeConstraints { (make) in
            make.centerY.equalTo(textField.snp.centerY).offset(0)
            make.left.equalTo(22)
            make.height.equalTo(18)
            make.width.equalTo(18)
        }
        
        // MARK: buttonRight
        
        contentView.addSubview(buttonRight)
        buttonRight.snp.makeConstraints { (make) in
            make.centerY.equalTo(textField.snp.centerY).offset(0)
            make.height.equalTo(18)
            make.width.equalTo(18)
            make.right.equalTo(-22)
        }
        
        // MARK: labelAccurancy
        
        contentView.addSubview(labelAccurancy)
        labelAccurancy.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(-6)
            make.left.equalTo(48)
            make.right.equalTo(-20)
        }
        
        // MARK: viewLine
        
        contentView.addSubview(viewLine)
        viewLine.snp.makeConstraints { (make) in
            make.top.equalTo(labelAccurancy.snp.bottom).offset(12)
            make.bottom.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ text: String, _ placeholder: String, _ accurancy: String, _ leftImage: UIImage?, _ rightImage: UIImage?) {
        textField.text = text
        textField.placeholder = placeholder
        labelAccurancy.text = accurancy
        buttonLeft.setImage(leftImage, for: UIControl.State.normal)
        buttonRight.setImage(rightImage, for: UIControl.State.normal)
    }
    
}

extension MapCompositeFieldFrom: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onTap?()
        return false
    }
    
}
