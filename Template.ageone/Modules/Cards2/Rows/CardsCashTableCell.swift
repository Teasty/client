//
//  CardsBaseTableCell.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 02/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class CardsCashTableCell: BaseTableCell {
    
    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: imageCard
    
    fileprivate let imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 16.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    // MARK: imageCheckmark
    
    fileprivate let imageCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.checkmark()
        return imageView
    }()
}

// MARK: Base methods

extension CardsCashTableCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: imageCard
        
        contentView.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        // MARK: imageCheckmark
        
        contentView.addSubview(imageCheckmark)
        imageCheckmark.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-20)
            make.height.equalTo(11)
            make.width.equalTo(15)
        }
        
        // MARK: labelTitle
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(imageIcon.snp.right).offset(10)
            make.right.equalTo(imageCheckmark.snp.left).offset(-10)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ isSelected: Bool = false) {
        labelTitle.text = "Наличные"
        imageIcon.image = R.image.cash()
        if isSelected {
            imageCheckmark.isHidden = false
        } else {
            imageCheckmark.isHidden = true
        }
    }
    
}

// MARK: Actions

extension CardsCashTableCell {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
