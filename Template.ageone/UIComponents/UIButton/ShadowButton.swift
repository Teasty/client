//
//  ShadowButton.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 02/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func render() {
        
        // MARK: parametrs
        
        backgroundColor = utils.constants.colors.yellow
        setTitleColor(utils.constants.colors.darkBlue, for: UIControl.State.normal)
        titleLabel?.font = UIFont(name: utils.constants.font.bold, size: 18.0)
        
        // MARK: corners and borders
        
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        
        // MARK: shadow
        
        layer.cornerRadius = 28.0
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        layer.shadowOffset.height = 4.0
        
    }
    
    // MARK: gradient
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let fromColor = UIColor(hexString: "#405ABE") ?? UIColor()
//        let toColor = UIColor(hexString: "#627FF2")?.withAlphaComponent(0.75) ?? UIColor()
//        self.applyGradient(withColours: [fromColor, toColor], gradientOrientation: GradientOrientation.horizontal)
    }
    
}

extension ShadowButton {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
