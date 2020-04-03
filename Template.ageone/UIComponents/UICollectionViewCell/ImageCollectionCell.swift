//
//  ImageCollectionCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class ImageCollectionCell: BaseCollectionCell {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: viewInner
    
    fileprivate let viewInner: UIView = {
        let view = UIView()
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        view.layer.shadowOffset.height = 1.0
        view.layer.cornerRadius = 12.0
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // MARK: imageBase
    
    fileprivate let imageBase: BaseImageView = {
        var imageView = BaseImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    
}

// MARK: renderUI

extension ImageCollectionCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: viewInner
        
        self.contentView.addSubview(viewInner)
        viewInner.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalTo(-12)
            make.left.equalTo(0)
            make.right.equalTo(-16)
        }
        
        // MARK: imageBase
        
        viewInner.addSubview(imageBase)
        imageBase.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(url: String? = nil, image: UIImage? = nil) {
        imageBase.image = R.image.placeHolder()
        if let image = image {
            imageBase.image = image
        }
        if let url = url {
            imageBase.loadImage(url)
//            imageBase.sd_setImage(with: URL(string: url), placeholderImage: R.image.placeHolder())
        }
    }
    
}

extension ImageCollectionCell {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
