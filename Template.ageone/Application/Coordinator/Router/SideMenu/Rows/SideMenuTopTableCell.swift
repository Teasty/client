//
//  Top.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class SideMenuTopTableCell: BaseTableCell {

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
    
    // MARK: imageGradient
    
    fileprivate let imageGradient: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.gradientSideMenu()
        return imageView
    }()
    
    // MARK: imageIcon
    
    fileprivate let imageIcon: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.user()
        return imageView
    }()

    // MARK: labelPhone
    
    fileprivate let labelPhone: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 16.0)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: buttonChange
    
//    public let buttonChange: BaseButton = {
//        let button = BaseButton()
//        button.setTitle("Изменить", for: UIControl.State.normal)
//        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        button.titleLabel?.font = UIFont(name: utils.constants.font.regular, size: 16.0)
//        button.layer.cornerRadius = 0.0
//        button.layer.borderWidth = 0.0
//        button.layer.borderColor = UIColor.clear.cgColor
//        button.backgroundColor = UIColor.clear
//        return button
//    }()
    
    // MARK: buttonClose
    
    public let buttonClose: BaseButton = {
        let button = BaseButton()
        button.setImage(R.image.close(), for: UIControl.State.normal)
        button.imageView?.tintColor = UIColor.white
        button.layer.cornerRadius = 0.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()
    
}

// MARK: Base methods

extension SideMenuTopTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: imageGradient
        
        contentView.addSubview(imageGradient)
        imageGradient.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(-16)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(160).priority(999)
        }
        
        // MARK: labelChange
        
//        contentView.addSubview(buttonChange)
//        buttonChange.snp.makeConstraints { (make) in
//            make.bottom.equalTo(imageGradient.snp.bottom).offset(-9)
//            make.centerX.equalTo(contentView.snp.centerX)
//        }
        
        // MARK: labelPhone
        
        contentView.addSubview(labelPhone)
        labelPhone.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        // MARK: imageIcon
        
        contentView.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelPhone.snp.top).offset(-20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        // MARK: buttonClose
        
        contentView.addSubview(buttonClose)
        buttonClose.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.left.equalTo(21)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }
        
    }
    
    // MARK: initialize

    public func initialize() {
        labelPhone.text = utils.formatter.phone("7\(user.phone)")
    }
    
}

// MARK: Actions

extension SideMenuTopTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
