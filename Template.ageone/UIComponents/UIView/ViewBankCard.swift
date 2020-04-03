//
//  RowBankCard.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 01/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class ViewBankCard: UIView {
    
    public var callback: ((String) -> Void)?
    fileprivate var element = Element()
    
    struct Element {
        var name = String()
        var value = String()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        configureUI()
        rednderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI

    // MARK: imageCard
    
    fileprivate let imageCard: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.placeHolder()
        return imageView
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 17.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    // MARK: imageCheckMark
    
    fileprivate let imageCheckMark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.checkmark()
        return imageView
    }()
    
    // MARK: configureUI
    
    fileprivate func configureUI() {
        backgroundColor = UIColor(hexString: "#F7F7F7") ?? UIColor()
    }
    
    fileprivate func rednderUI() {
        
        // MARK: imageCard
        
        addSubview(imageCard)
        imageCard.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(27)
            make.height.equalTo(15)
        }
        
        // MARK: labelTitle
        
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(imageCard.snp.right).offset(6)
        }
        
        // MARK: imageCheckMark
        
        addSubview(imageCheckMark)
        imageCheckMark.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ element: Element) {
        self.element = element
        self.labelTitle.text = element.name
    }
    
    public func toggleCheckMark(_ isChecked: Bool) {
        if isChecked {
            imageCheckMark.isHidden = false
        } else {
            imageCheckMark.isHidden = true
        }
    }
    
}

// MARK: action

extension ViewBankCard {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        callback?(element.value)
    }
    
}
