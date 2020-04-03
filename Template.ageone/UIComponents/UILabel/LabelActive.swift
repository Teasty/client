//
//  ActiveLabel.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import ActiveLabel

class LabelActive: ActiveLabel {
    
    public var onTap: (() -> Void)?

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initialize(_ fullText: String, _ selectedText: String, _ color: UIColor) {
        let linkOffer = ActiveType.custom(pattern: selectedText)
        enabledTypes = [linkOffer]
        text = fullText
        customColor[linkOffer] = color
        customSelectedColor[linkOffer] = color.withAlphaComponent(0.8)
        handleCustomTap(for: linkOffer) { [unowned self] _ in
            self.onTap?()
        }
    }
    
}
