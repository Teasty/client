//
//  CEImageView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 14/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class CEImageView: UIImageView {
    
    // MARK: override
    
    override init(image: UIImage?) {
        super.init(image: image)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: configureUI

extension CEImageView {
    
    fileprivate func configureUI() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
}
