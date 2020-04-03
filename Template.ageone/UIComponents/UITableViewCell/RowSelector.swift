//
//  RowSelector.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class RowSelector: BaseTableCell {

    public var callback: ((String) -> Void)?
    fileprivate var element = Element()
    
    struct Element {
        var name = String()
        var value = String()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
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
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: imageChevrone
    
    fileprivate let imageChevrone: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.chevroneRight()
        return imageView
    }()
}

// MARK: Base methods

extension RowSelector {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: labelTitle
        
        self.contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        // MARK: imageChevrone
        
        self.contentView.addSubview(imageChevrone)
        imageChevrone.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(-20)
            make.height.equalTo(10)
            make.width.equalTo(7)
        }
        
    }
    
    // MARK: initialize

    public func initialize(_ element: Element) {
        self.element = element
        self.labelTitle.text = element.name
    }
    
}

// MARK: action

extension RowSelector {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        callback?(element.value)
    }
    
}
