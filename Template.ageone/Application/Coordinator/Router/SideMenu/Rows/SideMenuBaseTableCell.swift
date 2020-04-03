//
//  Base.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class SideMenuBaseTableCell: BaseTableCell {

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
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 17.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
}

// MARK: Base methods

extension SideMenuBaseTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: labelTitle
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
    }
    
    // MARK: initialize

    public func initialize(_ title: String?) {
        guard let title = title else { return }
        labelTitle.text = title
    }
    
}

// MARK: Actions

extension SideMenuBaseTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
