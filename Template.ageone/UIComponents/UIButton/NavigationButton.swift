//
//  ButtonBasket.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class NavigationButton: UIButton {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        imageView?.tintColor = UIColor.black
        contentEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        imageView?.contentMode = .scaleAspectFit
        layer.cornerRadius = 0.0
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = UIColor.clear
        frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
}

extension NavigationButton {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
