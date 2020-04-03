//
//  ArticleBaseTableCell.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 05/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class ArticleBaseTableCell: BaseTableCell {
    
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
    
    // MARK: labelTitle
    
    public let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 18.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelText
    
    public let labelText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 16.0)
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#777777") ?? UIColor()
        label.numberOfLines = 0
        return label
    }()
    
}

// MARK: Base methods

extension ArticleBaseTableCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: labelTitle
        
        self.contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        // MARK: labelText
        
        self.contentView.addSubview(labelText)
        labelText.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(16)
            make.bottom.equalTo(-16)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ title: String, _ text: String) {
        labelTitle.text = title
        labelText.text = text
    }
    
}

// MARK: Actions

extension ArticleBaseTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
