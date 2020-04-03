//
//  Button.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class RowButton: BaseTableCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    public let button: ShadowButton = {
        let button = ShadowButton()
        return button
    }()
    
}

// MARK: Base methods

extension RowButton {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: GradientButton
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(56).priority(999)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ title: String) {
        button.setTitle(title, for: UIControl.State.normal)
    }
    
}
