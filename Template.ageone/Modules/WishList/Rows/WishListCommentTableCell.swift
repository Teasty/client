//
//  Commnet.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 06/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class WishListCommentTableCell: BaseTableCell {
    
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
    
    // MARK: imageIcon
    
    fileprivate let imageIcon: BaseImageView = {
        let imageView = BaseImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.comment()
        return imageView
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.darkGray
        label.numberOfLines = 0
        label.text = "Комментарий водителю"
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
    
}

// MARK: Base methods

extension WishListCommentTableCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: imageIcon
        
        contentView.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        // MARK: labelTitle
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(imageIcon.snp.right).offset(8)
            make.right.equalTo(-20)
        }
        
        // MARK: labelDescription
        
        contentView.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(8)
            make.bottom.equalTo(-8)
            make.left.equalTo(labelTitle.snp.left)
            make.right.equalTo(-20)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ text: String) {
        labelDescription.text = text
    }
    
}

// MARK: Actions

extension WishListCommentTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
