//
//  BaseButton.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseButton {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
