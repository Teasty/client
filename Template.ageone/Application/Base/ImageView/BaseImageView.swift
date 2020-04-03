//
//  BaseImageView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 28/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseImageView: UIImageView {

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = R.image.placeHolder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseImageView {
    
    public func loadImage(_ path: String?) {
        guard let unwarpPath = path else {
            log.error("Empty image path")
            return
        }
        if let url = URL(string: unwarpPath) {
//            kf.indicatorType = .activity
            kf.setImage(
                with: url,
                placeholder: UIImage(),
                options: [ .transition(.fade(0.5)) ]) { result in
                    switch result {
                    case .success (let value): log.info("Image downloaded: \(value.source.url?.absoluteString ?? "")")
                    case .failure (let error): log.info("Image failed: \(error.localizedDescription)")
                    }
            }
        } else {
            log.error("Wrong image path: \(unwarpPath)")
        }
    }
    
}
