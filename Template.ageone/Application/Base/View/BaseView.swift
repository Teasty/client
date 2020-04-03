//
//  BaseView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseView {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
